function [] = DLMI_vs_DLQR_experimental_comparison(t_dlqr_dr_exp,...
                                                   xmp_dlqr_dr_exp,...
                                                   ymp_dlqr_dr_exp,...
                                                   xc_dlqr_dr_exp,...
                                                   yc_dlqr_dr_exp, ...
                                                   rot_dlqr_dr_exp,...
                                                   rot_ref_dlqr_dr_exp,...
                                                   rwc_dlqr_dr_exp,...
                                                   t_dlmi_dr_exp,...
                                                   xmp_dlmi_dr_exp,...
                                                   ymp_dlmi_dr_exp,...
                                                   xc_dlmi_dr_exp,...
                                                   yc_dlmi_dr_exp,...
                                                   rot_dlmi_dr_exp,...
                                                   rot_ref_dlmi_dr_exp,...
                                                   rwc_dlmi_dr_exp,...
                                                   tractor_max_force,...
                                                   plot_enable)


    if(plot_enable)

        %% Plot parameters
    
        lw = 1.5;       
        transparency = 0.2;
        blue_color  = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        yellow_color = [0.9290 0.6940 0.1250];     

        %% Displacement and control of individual axes
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,2)
        %
        nexttile  
        p1 = plot(t_dlqr_dr_exp,xmp_dlqr_dr_exp','LineWidth',lw);
        hold on
        p2 = plot(t_dlmi_dr_exp,xmp_dlmi_dr_exp,'LineWidth',lw);
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        yticks([-0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2])
        %
        nexttile  
        plot(t_dlqr_dr_exp,ymp_dlqr_dr_exp','LineWidth',lw)
        hold on
        plot(t_dlmi_dr_exp,ymp_dlmi_dr_exp,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t_dlmi_dr_exp,xc_dlmi_dr_exp,'Color',orange_color,'LineWidth',lw)        
        hold on    
        plot(t_dlqr_dr_exp,xc_dlqr_dr_exp,'Color',blue_color,'LineWidth',lw)
        hold on        
        plot(t_dlmi_dr_exp,tractor_max_force*ones(size(t_dlmi_dr_exp)),'--k','LineWidth',lw)
        hold on
        plot(t_dlmi_dr_exp,-tractor_max_force*ones(size(t_dlmi_dr_exp)),'--k','LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{xc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        ylim([-tractor_max_force tractor_max_force])
        %
        nexttile 
        plot(t_dlmi_dr_exp,yc_dlmi_dr_exp,'Color',orange_color,'LineWidth',lw)        
        hold on        
        plot(t_dlqr_dr_exp,yc_dlqr_dr_exp,'Color',blue_color,'LineWidth',lw)
        hold on        
        plot(t_dlmi_dr_exp,tractor_max_force*ones(size(t_dlmi_dr_exp)),'--k','LineWidth',lw)
        hold on
        p3= plot(t_dlmi_dr_exp,-tractor_max_force*ones(size(t_dlmi_dr_exp)),'--k','LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{yc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        ylim([-tractor_max_force tractor_max_force])
        %
        lgd = legend([p1,p2,p3],{'DLQR controller','GCB2019 controller','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLMI/DLMI_vs_DLQR_experimental_comparison','epsc')

        %% Rotation and control

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11/2])
        tiledlayout(1,2)
        %
        nexttile  
        p1 = plot(t_dlqr_dr_exp,rot_dlqr_dr_exp,'Color',blue_color,'LineWidth',lw);
        hold on
        p2 = plot(t_dlmi_dr_exp,rot_dlmi_dr_exp,'Color',orange_color,'LineWidth',lw);
        hold on
        p3 = plot(t_dlmi_dr_exp,rot_ref_dlmi_dr_exp,'Color',yellow_color,'LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$\theta_{p_{cv}}(t)$ ($\deg$)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t_dlqr_dr_exp,rwc_dlqr_dr_exp,'Color',blue_color,'LineWidth',lw)
        hold on
        plot(t_dlmi_dr_exp,rwc_dlmi_dr_exp,'Color',orange_color,'LineWidth',lw)
        hold on        
        plot(t_dlqr_dr_exp,(1460+250)*ones(size(t_dlqr_dr_exp)),'--k','LineWidth',lw)
        hold on
        p4= plot(t_dlqr_dr_exp,(1460-250)*ones(size(t_dlqr_dr_exp)),'--k','LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$u_{rwc}(t)$ ($\mu$s)','Interpreter','latex')
        xlim([0 60])
        lgd = legend([p1,p2,p3,p4],{'DLQR controller','GCB2019 controller','Angular position reference','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLMI/DLMI_vs_DLQR_experimental_rotation','epsc')


        %% Distance from the origin

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_dlqr_dr_exp,sqrt(xmp_dlqr_dr_exp.^2+ymp_dlqr_dr_exp.^2),'Color', blue_color, 'LineWidth', lw);
        hold on
        plot(t_dlmi_dr_exp,sqrt(xmp_dlmi_dr_exp.^2+ymp_dlmi_dr_exp.^2),'Color', orange_color, 'LineWidth', lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('Distance from the origin (m)','Interpreter','latex')
        legend({'DLQR controller','GCB2019 controller'}, ...
            'Location','southoutside','Orientation','horizontal', ...
            'Interpreter','latex')
        xlim([0 60])
        saveas(gcf,'Figures/DLMI/DLMI_vs_DLQR_experimental_distance','epsc')
 
    end

end
