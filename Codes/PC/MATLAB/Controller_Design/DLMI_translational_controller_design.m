function [A_hat_r, ...
          B_hat_r, ... 
          C_hat_r, ...
          D_hat_r, ...
          Hinf_sim,...
          w0] = DLMI_translational_controller_design (m, ...
                                                      Gm, ...
                                                      ts, ...
                                                      tm, ...
                                                      h, ...
                                                      design_controller, ...
                                                      plot_enable)

    % Camera delay 
    
    [num_s,den_s] = pade(ts,2);
    
    [As,Bs,Cs,Ds] = tf2ss(num_s,den_s);
    
    % Motor 

    [Am,Bm,Cm,Dm] = tf2ss(Gm.num{1},Gm.den{1});
    
    % Motor delay 
    
    [num_md,den_md] = pade(tm,2);
    
    [Amd,Bmd,Cmd,Dmd] = tf2ss(num_md,den_md);
    
    % System matrices
    
    A = [    0           1         zeros(1,2)         0        zeros(1,2)    ; ...
             0           0         zeros(1,2)   (1/m)*Dmd*Cm   (1/m)*Cmd     ; ...
             Bs       zeros(2,1)       As        zeros(2,1)    zeros(2,2)    ; ...
         zeros(1,1)      0         zeros(1,2)        Am        zeros(1,2)    ; ...
         zeros(2,1)   zeros(2,1)   zeros(2,2)      Bmd*Cm          Amd      ];
    
    B = [0 ; (1/m)*Dmd*Dm ; zeros(2,1) ; Bm ; Bmd*Dm];
    
    Ec = [0 ; (1/m) ; zeros(2,1)  ; 0 ; zeros(2,1)];
    
    Cc = [1 0 zeros(1,2) 0 zeros(1,2)];
    
    Dc = 0;
    
    Cd = [Ds 0 Cs 0 zeros(1,2)];
    
    %% Controller design
    
    ite = 1000;
    theta = 100;
    l = 4;
    
    if(design_controller)
        [Hinf,A_hat,B_hat,C_hat,D_hat,calc_runtime,VAR,NLMIs,feasibility] = ...
        H_inf_output_feedback_controller_adapted(A,B,Ec,Cd,Cc,Dc,h,l,theta,ite)
    
        save('Controllers/controller','Hinf','A_hat','B_hat','C_hat', ...
             'D_hat','calc_runtime','VAR','NLMIs','feasibility')    
    else
        load('Controllers\controller.mat')
    end

    Hinf

    sys_controller = ss(A_hat,B_hat,C_hat,D_hat,h);
    
    %% Reduction of controller order
    
    sys = ss(A_hat,B_hat,C_hat,D_hat,h);
    R = reducespec(sys,'balanced');
    R = process(R);
    rsys = getrom(R,Order=3);
    
    A_hat_r = rsys.A;
    B_hat_r = rsys.B;
    C_hat_r = rsys.C;
    D_hat_r = rsys.D;

    sys_controller_reduced = ss(A_hat_r,B_hat_r,C_hat_r,D_hat_r,h);
    
    % Controller storage
    
    if(design_controller)
        csvwrite('Controllers/AMatrixDLMIController.csv', A_hat_r);
        csvwrite('Controllers/BMatrixDLMIController.csv', B_hat_r);
        csvwrite('Controllers/CMatrixDLMIController.csv', C_hat_r);
        csvwrite('Controllers/DMatrixDLMIController.csv', D_hat_r);
    end
    
    %% Calculation of the Hinf norm by frequency
    
    if(design_controller)
        omega_max = pi;
        omega_min = omega_max/1000;
        number_frequencies = 100;
        
        array_omega = logspace(log10(omega_min),log10(omega_max),number_frequencies);

        simInput = Simulink.SimulationInput('testHinfControlOutputFeedback');
        simInput = simInput.setVariable('A',A);
        simInput = simInput.setVariable('B',B);
        simInput = simInput.setVariable('Ec',Ec);
        simInput = simInput.setVariable('Cc',Cc);
        simInput = simInput.setVariable('Dc',Dc);
        simInput = simInput.setVariable('Cd',Cd);
        simInput = simInput.setVariable('A_hat_r',A_hat_r);
        simInput = simInput.setVariable('B_hat_r',B_hat_r);
        simInput = simInput.setVariable('C_hat_r',C_hat_r);
        simInput = simInput.setVariable('D_hat_r',D_hat_r);
            
        for index_omega = 1:number_frequencies
            omega = array_omega(index_omega);
            simInput = simInput.setVariable('omega',omega);
            simout = sim(simInput);
            hinf_norm(index_omega) = simout.norm_z / simout.norm_w;    
        end    
    
        save('Controllers/Hinf_frequency','array_omega','hinf_norm')
    else
        load('Controllers/Hinf_frequency')
    end
    
    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(array_omega,hinf_norm,'LineWidth',1.5)
        grid on
        xlabel('Frequency (rad/s)', 'Interpreter','latex')
        ylabel('Gain', 'Interpreter','latex')
        saveas(gcf,'Figures/DLMI/disturbance_frequencies','epsc')


        % Bode diagram

        [mag_c_aux,phase_c_aux,wout_c] = bode(sys_controller);
        [mag_cr_aux,phase_cr_aux,wout_cr] = bode(sys_controller_reduced);

        mag_c = squeeze(20*log10(mag_c_aux));
        mag_cr = squeeze(20*log10(mag_cr_aux));

        phase_c = squeeze(phase_c_aux);        
        phase_cr = squeeze(phase_cr_aux);

        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,1)
        %
        nexttile  
        p1 = semilogx(wout_c,mag_c,'LineWidth',lw);
        hold on
        p2 = semilogx(wout_cr,mag_cr,'--','LineWidth',lw);
        grid on
        ylabel('Magnitude (dB)','Interpreter','latex')
        xticks([10^-2 10^-1 10^0 10^1 10^2])
        %
        nexttile 
        semilogx(wout_c,phase_c,'LineWidth',lw);
        hold on
        semilogx(wout_cr,phase_cr,'--','LineWidth',lw);
        grid on
        xlabel('Frequency (rad/s)','Interpreter','latex')
        ylabel('Phase ($\deg$)','Interpreter','latex')
        xticks([10^-2 10^-1 10^0 10^1 10^2])
        lgd = legend([p1,p2],{'Designed controller','Reduced order controller'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLMI/bode_diagram_controllers','epsc')

    end
    
    Hinf_sim = max(hinf_norm);
    w0 = array_omega(find(hinf_norm == max(hinf_norm)));

end