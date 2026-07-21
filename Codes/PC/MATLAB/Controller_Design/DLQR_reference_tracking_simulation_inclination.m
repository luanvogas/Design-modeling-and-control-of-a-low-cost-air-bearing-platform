function [t,...
          x_measured_position,...
          y_measured_position,...
          x_control,...
          y_control] = DLQR_reference_tracking_simulation_inclination(t_dlqr,...
                                                                      x_ref_dlqr,...
                                                                      y_ref_dlqr,...
                                                                      xmp_dlqr,...
                                                                      ymp_dlqr,...
                                                                      xc_dlqr,...
                                                                      yc_dlqr, ...
                                                                      tractor_max_force, ...
                                                                      plot_enable)

    % Simulation
    
    DLQR_ref_track_sim = sim('DLQR_reference_tracking_inclination_effect_simulink');
    
    t = DLQR_ref_track_sim.time.Data;
    x_measured_position = DLQR_ref_track_sim.x_measured_position.Data;
    y_measured_position = DLQR_ref_track_sim.y_measured_position.Data;
    x_control = DLQR_ref_track_sim.x_control.Data;
    y_control = DLQR_ref_track_sim.y_control.Data;
    F_incx = DLQR_ref_track_sim.Fincx.Data;
    F_incy = DLQR_ref_track_sim.Fincy.Data;

    if(plot_enable)

        % Parameters

        lw = 1.5;        
        blue_color  = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        yellow_color = [0.9290 0.6940 0.1250];     
                        
        % Reference tracking
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11*(3/2)])
        tiledlayout(3,2)
        %
        nexttile  
        p1 = plot(t_dlqr,xmp_dlqr','Color',orange_color,'LineWidth',lw);
        hold on
        p2 = plot(t,x_measured_position,'Color',yellow_color,'LineWidth',lw);
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        plot(t_dlqr,ymp_dlqr','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t,y_measured_position,'Color',yellow_color,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t_dlqr,xc_dlqr','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t,x_control,'Color',yellow_color,'LineWidth',lw)
        hold on
        p3 = plot(t,tractor_max_force*ones(size(x_control)),'--k','LineWidth',lw);
        hold on
        plot(t,-tractor_max_force*ones(size(x_control)),'--k','LineWidth',lw)
        grid on
        ylabel('$F_{xc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t_dlqr,yc_dlqr','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t,y_control,'Color',yellow_color,'LineWidth',lw)
        hold on
        plot(t,tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        hold on
        plot(t,-tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        grid on
        ylabel('$F_{yc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        plot(t,F_incx','Color',yellow_color,'LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{x_{inc}}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        plot(t,F_incy','Color',yellow_color,'LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{y_{inc}}(t)$ (N)','Interpreter','latex')
        %
        lgd = legend([p1,p2,p3],{'Nominal simulation','Simulation with inclination effect','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/model_simulation_glass_inclination','epsc')            
        
        % Circle tracking
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(x_ref_dlqr,y_ref_dlqr,'Color',blue_color,'LineWidth',lw)
        hold on
        plot(xmp_dlqr,ymp_dlqr,'Color',orange_color,'LineWidth',lw)
        hold on
        plot(x_measured_position,y_measured_position,'Color',yellow_color,'LineWidth',lw)
        grid on
        xlabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        legend('Reference','Nominal simulation','Simulation with inclination effect','Location',[0.390692222209328,0.477179998462191,0.250558878638184,0.080048075318336],'Interpreter','latex')
        xlim([-0.4 0.4])
        ylim([-0.4 0.4])
        saveas(gcf,'Figures/DLQR/circular_path_model_simulation_glass_inclination','epsc')    
    end
end