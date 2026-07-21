function [t,...
          x_reference,...
          y_reference,...
          x_measured_position,...
          y_measured_position,...
          x_control,...
          y_control] = DLQR_reference_tracking_simulation(tractor_max_force, ...
                                                          plot_enable)
    

    % Simulation
    
    DLQR_ref_track_sim = sim('DLQR_reference_tracking_simulink');
    
    t = DLQR_ref_track_sim.time.Data;
    x_measured_position = DLQR_ref_track_sim.x_measured_position.Data;
    y_measured_position = DLQR_ref_track_sim.y_measured_position.Data;
    x_reference = DLQR_ref_track_sim.x_reference.Data;
    y_reference = DLQR_ref_track_sim.y_reference.Data;
    x_control = DLQR_ref_track_sim.x_control.Data;
    y_control = DLQR_ref_track_sim.y_control.Data;

    if(plot_enable)

        % Parameters

        lw = 1.5;        
        blue_color  = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        yellow_color = [0.9290 0.6940 0.1250];     
        
        % Reference signals
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11/2])
        tiledlayout(1,2)
        %
        nexttile  
        plot(t,x_reference','Color',blue_color,'LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$r_x(t)$ (m)','Interpreter','latex')
        %
        nexttile  
        plot(t,y_reference,'Color',orange_color,'LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$r_y(t)$ (m)','Interpreter','latex')
        %
        % legend('x-axis','y-axis','Location','best','Interpreter','latex')
        xlim([0 60])
        saveas(gcf,'Figures/DLQR/circle_references','epsc')
        
        % Control task
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(x_reference,y_reference','LineWidth',lw);
        hold on
        plot(0,0.3,'*r','LineWidth',2*lw);
        hold on
        annotation('arrow', [0.52 0.48], [0.823 0.823], 'Color', 'k', 'LineWidth', 1.5);
        annotation('arrow', [0.39 0.46], [0.485 0.485], 'Color', 'k', 'LineWidth', 1.5);
        plot(0.35,0.35,'*w','LineWidth',2*lw)
        grid on
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend('Reference','Start point','Movement direction','Location',[0.381913436144378,0.464061554807432,0.274015619621975,0.115865382208274],'Interpreter','latex')
        xlim([-0.4 0.4])
        ylim([-0.4 0.4])
        saveas(gcf,'Figures/DLQR/control_task','epsc')
        
        % Reference tracking
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,2)
        %
        nexttile  
        p1 = plot(t,x_reference','LineWidth',lw);
        hold on
        p2 = plot(t,x_measured_position,'LineWidth',lw);
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        plot(t,y_reference','LineWidth',lw)
        hold on
        plot(t,y_measured_position,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t,x_control,'Color',orange_color,'LineWidth',lw)
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
        plot(t,tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        hold on
        plot(t,-tractor_max_force*ones(size(y_control)),'--k','LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{yc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        %
        lgd = legend([p1,p2,p3],{'Reference','Nominal simulation','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/model_simulation','epsc')
        
        % Circle tracking
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(x_reference,y_reference,'LineWidth',lw)
        hold on
        plot(x_measured_position,y_measured_position,'LineWidth',lw)
        grid on
        xlabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        legend('Reference','Nominal simulation','Location',[0.390692222209328,0.477179998462191,0.250558878638184,0.080048075318336],'Interpreter','latex')
        xlim([-0.4 0.4])
        ylim([-0.4 0.4])
        saveas(gcf,'Figures/DLQR/circular_path_model_simulation','epsc')    
    end
end