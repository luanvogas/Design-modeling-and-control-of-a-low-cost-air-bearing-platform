function [] = DLMI_vs_DLQR_numerical_comparison(t_dlqr_dr_sim,...
                                                xd_dlqr_dr_sim,...
                                                xmp_dlqr_dr_sim,...
                                                ymp_dlqr_dr_sim,...
                                                xc_dlqr_dr_sim,...
                                                yc_dlqr_dr_sim, ...
                                                t_dlmi_dr_sim,...
                                                xd_dlmi_dr_sim,...
                                                xmp_dlmi_dr_sim,...
                                                ymp_dlmi_dr_sim,...
                                                xc_dlmi_dr_sim,...
                                                yc_dlmi_dr_sim,...
                                                tractor_max_force,...
                                                plot_enable)


    if(plot_enable)

        %% Plot parameters
    
        lw = 1.5;       
        transparency = 0.2;
        blue_color  = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        yellow_color = [0.9290 0.6940 0.1250];    

        %% Distubance signal

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_dlqr_dr_sim,xd_dlqr_dr_sim,'LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$w_{h_{cx}}(t)$ (N)','Interpreter','latex')
        saveas(gcf,'Figures/DLMI/disturbance_signal','epsc')

        %% Displacement and control of individual axes
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,2)
        
        nexttile  
        p1 = plot(t_dlqr_dr_sim,xmp_dlqr_dr_sim','LineWidth',lw);
        hold on
        p2 = plot(t_dlmi_dr_sim,xmp_dlmi_dr_sim,'LineWidth',lw);
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        yticks([-0.1 -0.05 0 0.05 0.1])        
        nexttile  
        plot(t_dlqr_dr_sim,ymp_dlqr_dr_sim','LineWidth',lw)
        hold on
        plot(t_dlmi_dr_sim,ymp_dlmi_dr_sim,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])        
        ax3 = nexttile; 
        plot(t_dlqr_dr_sim,xc_dlqr_dr_sim,'Color',blue_color,'LineWidth',lw)
        hold on    
        plot(t_dlmi_dr_sim,xc_dlmi_dr_sim,'Color',orange_color,'LineWidth',lw)
        hold on        
        plot(t_dlmi_dr_sim,tractor_max_force*ones(size(t_dlmi_dr_sim)),'--k','LineWidth',lw)
        hold on
        p3 = plot(t_dlmi_dr_sim,-tractor_max_force*ones(size(t_dlmi_dr_sim)),'--k','LineWidth',lw);
        hold on  
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{xc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])        
        ax_zoom = axes('Position',[0.20 0.435 0.1 0.07]);
        box on              
        plot(t_dlqr_dr_sim,xc_dlqr_dr_sim,'Color',blue_color,'LineWidth',lw)
        hold on    
        plot(t_dlmi_dr_sim,xc_dlmi_dr_sim,'Color',orange_color,'LineWidth',lw)        
        grid on
        xlim([5 15])       
        set(ax_zoom,'HandleVisibility','off')        
        nexttile 
        plot(t_dlqr_dr_sim,yc_dlqr_dr_sim,'Color',blue_color,'LineWidth',lw)
        hold on        
        plot(t_dlmi_dr_sim,yc_dlmi_dr_sim,'Color',orange_color,'LineWidth',lw)
        hold on        
        plot(t_dlmi_dr_sim,tractor_max_force*ones(size(t_dlmi_dr_sim)),'--k','LineWidth',lw)
        hold on
        plot(t_dlmi_dr_sim,-tractor_max_force*ones(size(t_dlmi_dr_sim)),'--k','LineWidth',lw)        
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{yc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])        
        lgd = legend([p1 p2 p3],{'DLQR controller','GCB2019 controller','Saturation bounds'},'Interpreter','latex');
        lgd.Layout.Tile = 'south';        
        saveas(gcf,'Figures/DLMI/DLMI_vs_DLQR_numerical_comparison','epsc')

        %% Distance from the origin

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_dlqr_dr_sim, sqrt(xmp_dlqr_dr_sim.^2 + ymp_dlqr_dr_sim.^2),'Color', blue_color, 'LineWidth', lw);
        hold on
        plot(t_dlmi_dr_sim, sqrt(xmp_dlmi_dr_sim.^2 + ymp_dlmi_dr_sim.^2),'Color', orange_color, 'LineWidth', lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('Distance from the origin (m)','Interpreter','latex')
        legend({'DLQR controller','GCB2019 controller'}, ...
            'Location','southoutside','Orientation','horizontal', ...
            'Interpreter','latex')
        saveas(gcf,'Figures/DLMI/DLMI_vs_DLQR_numerical_distance','epsc')
    end

end
