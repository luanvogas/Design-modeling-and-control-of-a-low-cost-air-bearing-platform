function [t,...
          x_measured_position,...
          y_measured_position,...
          x_control,...
          y_control] = DLQR_reference_tracking_simulation_noise_inc_comp(t_dlqr,...
                                                                         x_ref_dlqr,...
                                                                         y_ref_dlqr,...
                                                                         xmp_dlqr_inc_comp,...
                                                                         ymp_dlqr_inc_comp,...
                                                                         xc_dlqr_inc_comp,...
                                                                         yc_dlqr_inc_comp, ...
                                                                         tractor_max_force, ...
                                                                         plot_enable)

    % Simulation
    
    DLQR_ref_track_sim = sim('DLQR_reference_tracking_noise_inc_comp_simulink');
    
    t = DLQR_ref_track_sim.time.Data;
    x_measured_position = DLQR_ref_track_sim.x_measured_position.Data;
    y_measured_position = DLQR_ref_track_sim.y_measured_position.Data;
    x_control = DLQR_ref_track_sim.x_control.Data;
    y_control = DLQR_ref_track_sim.y_control.Data;
    noise = DLQR_ref_track_sim.noise.Data;

    if(plot_enable)

        % Parameters

        lw = 1.5;        
        blue_color  = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        yellow_color = [0.9290 0.6940 0.1250];  

        % Injected noise

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t,noise,'Color',blue_color,'LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$w(t)$ (m)','Interpreter','latex')
        saveas(gcf,'Figures/DLQR/noise_signal','epsc') 
                        
        % Reference tracking
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,2)
        %
        nexttile  
        p1 = plot(t_dlqr,xmp_dlqr_inc_comp','Color',blue_color,'LineWidth',lw);
        hold on
        p2 = plot(t,x_measured_position,'Color',orange_color,'LineWidth',lw);
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        plot(t_dlqr,ymp_dlqr_inc_comp','Color',blue_color,'LineWidth',lw)
        hold on
        plot(t,y_measured_position,'Color',orange_color,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t,x_control,'Color',orange_color,'LineWidth',lw)
        hold on
        plot(t_dlqr,xc_dlqr_inc_comp','Color',blue_color,'LineWidth',lw)
        hold on
        p3 = plot(t,tractor_max_force*ones(size(x_control)),'--k','LineWidth',lw);
        hold on
        plot(t,-tractor_max_force*ones(size(x_control)),'--k','LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{xc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t,y_control,'Color',orange_color,'LineWidth',lw)
        hold on
        plot(t_dlqr,yc_dlqr_inc_comp','Color',blue_color,'LineWidth',lw)
        hold on        
        plot(t,tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        hold on
        plot(t,-tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{yc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        %
        lgd = legend([p1,p2,p3],{'Noise-free simulation','Simulation with measurement noise','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/model_simulation_noise','epsc')        
           
    end
end