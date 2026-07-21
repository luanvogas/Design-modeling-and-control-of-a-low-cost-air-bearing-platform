function [K] = DLQR_translational_controller(m, ...
                                             Gm, ...
                                             T, ...
                                             ts, ...
                                             tm, ...
                                             dist_max_error, ...
                                             uproj, ...
                                             plot_enable, ...
                                             print_enable)

    %% Plant transfer function
    
    Gp = tf([1],[m 0 0]);

    %% Delays

    td = ts + tm;

    %% Actuator-plant transfer function

    Gap_c = Gm * Gp;

    %% Discretization with delay

    [Aap_d,Bap_d,Cap_d,Dap_d] = discretization_with_delay(Gap_c,td,T);

    %% State-space representation
    
    [num_ap,den_ap] = ss2tf(Aap_d,Bap_d,Cap_d,Dap_d);
    
    Gap = tf(num_ap,den_ap,T);
    
    b3_ss = num_ap(2);
    b2_ss = num_ap(3);
    b1_ss = num_ap(4);
    b0_ss = num_ap(5);
    a3_ss = den_ap(2);
    a2_ss = den_ap(3);
    a1_ss = den_ap(4);
    a0_ss = den_ap(5);
    
    A = [-a3_ss -a2_ss -a1_ss -a0_ss b2_ss b1_ss b0_ss ; 
          1 0 0 0 0 0 0 ;
          0 1 0 0 0 0 0 ;
          0 0 1 0 0 0 0 ;
          0 0 0 0 0 0 0 ;
          0 0 0 0 1 0 0 ;
          0 0 0 0 0 1 0 ];
    
    B = [b3_ss ; 0 ; 0 ; 0 ; 1 ; 0 ; 0];
    
    % Open loop eigenvalues

    if(print_enable)
        display('Open loop eigenvalues:')
        eig(A)
    end
    
    %% Controllability
    
    Pc = [B A*B A^2*B A^3*B A^4*B A^5*B A^6*B];
    
    if(print_enable)
        if (rank(Pc) == 7)
            display('The system is controllable!')
        end
    end
    
    %% Controllable canonical form
    
    Pc_inv = eye(7)/Pc;
    
    h = Pc_inv(end,:);
    
    T_sim = [h ; h*A ; h*A^2 ; h*A^3 ; h*A^4 ; h*A^5 ; h*A^6];    
   
    A_b = T_sim*A/T_sim;
    
    B_b = T_sim*B;

    if(print_enable)
        display('Controllable canonical form:')

        A_b
        B_b
    end
    
    a_line = A_b(end,:);
    a0_b = -a_line(1);
    a1_b = -a_line(2);
    a2_b = -a_line(3);
    a3_b = -a_line(4);
    a4_b = -a_line(5);
    a5_b = -a_line(6);
    a6_b = -a_line(7);
    
    polos_G = roots([1 a6_b a5_b a4_b a3_b a2_b a1_b a0_b]);
    
    %% Controller design
    
    zeros_G = [];
    
    [G_num,G_den] = zp2tf(zeros_G',polos_G,1);
    
    Gz = tf(G_num,G_den,T);
    
    C = G_num(end:-1:2);
    Gz_inv = tf(G_num(end:-1:1),G_den(end:-1:1),T);
    H = Gz_inv*Gz;
    
    % Rlocus 
    
    N = 1000;
    q = logspace(-10,2,N);
    
    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        hold on
        
        for i = 1:N
            pp = pole(feedback(q(i)*H,1));
            plot(pp,'.b')
        end
        xlabel('Real Axis','Interpreter','latex')
        ylabel('Imaginary Axis','Interpreter','latex')
        zgrid
        axis([-1 1 -1 1])
        saveas(gcf,'Figures/DLQR/root_locus_translation','epsc')
    end    
        
    x0 = [dist_max_error ; dist_max_error ; dist_max_error ; dist_max_error ; 0 ; 0 ; 0];
    
    best_u0 = 0;

    for i = 1:N    
        q_proj = q(i);    
        Q = q_proj*(C'*C);
        R = 1;
        
        [K_b,S,e] = dlqr(A_b,B_b,Q,R);
    
        K = K_b * T_sim;
    
        u0 = -K*x0;
    
        if((abs(u0) > best_u0) && (abs(u0) <= uproj))
            best_u0 = abs(u0);
            best_i = i;
        end
    end   
    
    q_proj = q(best_i);
    
    Q = q_proj*(C'*C);
    R = 1;
    
    [K_b,S,e] = dlqr(A_b,B_b,Q,R);
        
    K = K_b * T_sim;
    
    u0 = -K*x0;

end


