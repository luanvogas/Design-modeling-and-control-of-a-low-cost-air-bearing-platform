function [t,...
          x_measured_position,...
          y_measured_position,...
          x_control,...
          y_control] = DLQR_reference_tracking_simulation_inclination_compensation(t_dlqr,...
                                                                                   x_ref_dlqr,...
                                                                                   y_ref_dlqr,...
                                                                                   xmp_dlqr,...
                                                                                   ymp_dlqr,...
                                                                                   xmp_dlqr_inc,...
                                                                                   ymp_dlqr_inc,...
                                                                                   xc_dlqr,...
                                                                                   yc_dlqr, ...
                                                                                   tractor_max_force, ...
                                                                                   plot_enable)

    % Simulation
    
    DLQR_ref_track_sim = sim('DLQR_reference_tracking_inclination_compensation_simulink');
    
    t = DLQR_ref_track_sim.time.Data;
    x_measured_position = DLQR_ref_track_sim.x_measured_position.Data;
    y_measured_position = DLQR_ref_track_sim.y_measured_position.Data;
    x_control = DLQR_ref_track_sim.x_control.Data;
    y_control = DLQR_ref_track_sim.y_control.Data;

    if(plot_enable)

        % Parameters

        lw = 1.5;        
        blue_color  = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        yellow_color = [0.9290 0.6940 0.1250];    
        purple_color = [0.5020 0 0.5020];     
                        
        % Reference tracking
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,2)
        %
        nexttile  
        set(gcf,'units','centimeters','position',[0,0,15,11])
        p1 = plot(t_dlqr,xmp_dlqr','Color',orange_color,'LineWidth',lw);
        hold on
        p2 = plot(t,x_measured_position,'-.','Color',purple_color,'LineWidth',lw);
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_dlqr,ymp_dlqr','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t,y_measured_position,'-.','Color',purple_color,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_dlqr,xc_dlqr','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t,x_control,'-.','Color',purple_color,'LineWidth',lw)
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
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_dlqr,yc_dlqr','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t,y_control,'-.','Color',purple_color,'LineWidth',lw)
        hold on
        plot(t,tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        hold on
        plot(t,-tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{yc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        %
        lgd = legend([p1,p2,p3],{'Nominal simulation','Simulation with compensated inclination','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/model_simulation_glass_inclination_compensation','epsc')
        
        % Circle tracking
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(xmp_dlqr,ymp_dlqr,'Color',orange_color,'LineWidth',lw)        
        hold on
        plot(xmp_dlqr_inc,ymp_dlqr_inc,'Color',yellow_color,'LineWidth',lw)
        hold on
        plot(x_measured_position,y_measured_position,'-.','Color',purple_color,'LineWidth',lw)
        grid on
        xlabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        legend('Nominal simulation','Simulation with inclination effect','Simulation with compensated inclination','Location',[0.390692222209328,0.477179998462191,0.250558878638184,0.080048075318336],'Interpreter','latex')
        xlim([-0.4 0.4])
        ylim([-0.4 0.4])
        saveas(gcf,'Figures/DLQR/circular_path_model_simulation_glass_inclination_compensation','epsc')    
    end
end