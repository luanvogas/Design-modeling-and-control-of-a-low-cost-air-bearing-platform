function [] = DLQR_experimental_reference_tracking_inclination_compensation(t_dlqr,...
                                                                            t_dlqr_exp,...
                                                                            x_ref_dlqr,...
                                                                            y_ref_dlqr,...
                                                                            xmp_dlqr_exp,...
                                                                            ymp_dlqr_exp,...
                                                                            xcont_dlqr_exp,...
                                                                            ycont_dlqr_exp,...
                                                                            rot_ref_dlqr_exp,...
                                                                            rot_dlqr_exp,...
                                                                            rw_control_dlqr_exp,...
                                                                            tractor_max_force,...
                                                                            plot_enable)

    if(plot_enable)

        %% Experimental data loading
    
        filename = 'Experimental_Data\control_data_DLQR_reference_tracking_compensated.csv';
        data = csvread(filename);
        
        t_exp = data(:,2);
        xmp_exp = data(:,11);
        ymp_exp = data(:,12);
        rot_exp = data(:,10);
        rot_ref_exp = data(:,96);
        ang_vel = data(:,57);
        rw_control = data(:,73);
        xcont_exp = data(:,43);
        ycont_exp = data(:,44);
        

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
        p0 = plot(t_dlqr,x_ref_dlqr,'Color',blue_color,'LineWidth',lw);
        hold on
        p1 = plot(t_dlqr_exp,xmp_dlqr_exp','Color',orange_color,'LineWidth',lw)
        hold on
        p2 = plot(t_exp,xmp_exp,'Color',yellow_color,'LineWidth',lw)
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        plot(t_dlqr,y_ref_dlqr,'Color',blue_color,'LineWidth',lw);
        hold on
        plot(t_dlqr_exp,ymp_dlqr_exp','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t_exp,ymp_exp,'Color',yellow_color,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t_dlqr_exp,xcont_dlqr_exp,'Color',orange_color,'LineWidth',lw)
        hold on    
        plot(t_exp,xcont_exp,'Color',yellow_color,'LineWidth',lw)
        hold on
        hold on        
        plot(t_dlqr_exp,tractor_max_force*ones(size(t_dlqr_exp)),'--k','LineWidth',lw)
        hold on
        plot(t_dlqr_exp,-tractor_max_force*ones(size(t_dlqr_exp)),'--k','LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{xc}$ (N)','Interpreter','latex')
        xlim([0 60])
        ylim([-tractor_max_force,tractor_max_force])
        %
        nexttile 
        plot(t_dlqr_exp,ycont_dlqr_exp,'Color',orange_color,'LineWidth',lw)
        hold on        
        plot(t_exp,ycont_exp,'Color',yellow_color,'LineWidth',lw)
        hold on
        plot(t_dlqr_exp,tractor_max_force*ones(size(t_dlqr_exp)),'--k','LineWidth',lw)
        hold on
        p3= plot(t_dlqr_exp,-tractor_max_force*ones(size(t_dlqr_exp)),'--k','LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{yc}$ (N)','Interpreter','latex')
        xlim([0 60])
        ylim([-tractor_max_force,tractor_max_force])
        %
        lgd = legend([p0,p1,p2,p3],{'Reference','Experimental results with inclination effect ','Experimental results with compensated inclination','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/experimental_result_with_compensation','epsc')

        %% Rotation and control of individual axes

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11/2])
        tiledlayout(1,2)
        %
        nexttile  
        p2 = plot(t_exp,rot_exp,'Color',orange_color,'LineWidth',lw);
        hold on
        p1 = plot(t_exp,rot_ref_exp,'Color',blue_color,'LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$\theta_{p_{cv}}(t)$ ($\deg$)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot(t_exp,rw_control,'Color',orange_color,'LineWidth',lw)
        hold on        
        plot(t_exp,(1460+250)*ones(size(t_exp)),'--k','LineWidth',lw)
        hold on
        p3= plot(t_exp,(1460-250)*ones(size(t_exp)),'--k','LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$u_{rwc}(t)$ ($\mu$s)','Interpreter','latex')
        xlim([0 60])
        ylim([1210 1710])
        lgd = legend([p1,p2,p3],{'Reference','Experimental results','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/experimental_result_rotation_with_compensation','epsc')


        %% 2D Reference Tracking 

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(x_ref_dlqr,y_ref_dlqr,'Color',blue_color,'LineWidth',lw);
        hold on
        plot(xmp_dlqr_exp,ymp_dlqr_exp,'Color',orange_color,'LineWidth',lw);
        hold on
        plot(xmp_exp,ymp_exp,'Color',yellow_color,'LineWidth',lw);
        grid on
        xlabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        legend('Reference','Experimental results with inclination effect ','Experimental results with compensated inclination','Location',[0.385881642846781,0.461657708653586,0.2625518693565,0.115865382208274],'Interpreter','latex')
        saveas(gcf,'Figures/DLQR/circular_path_experimental_result_with_compensation','epsc')

        %% Evaluation of the compensation 

        distance_without_comp = sqrt(xmp_dlqr_exp.^2 + ymp_dlqr_exp.^2);
        distance_with_comp = sqrt(xmp_exp.^2 + ymp_exp.^2);
       
        error_without_comp = abs(distance_without_comp - 0.3);
        error_with_comp = abs(distance_with_comp - 0.3);

        RMSE_without_comp = sqrt(mean((distance_without_comp - 0.3).^2))
        RMSE_with_comp = sqrt(mean((distance_with_comp - 0.3).^2))

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_dlqr_exp,error_without_comp,'Color',orange_color,'LineWidth',lw);
        hold on
        plot(t_exp,error_with_comp,'Color',yellow_color,'LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('Absolute Radial Error (m)','Interpreter','latex')
        xlim([0 60])
        legend('Experimental results with inclination effect ','Experimental results with compensated inclination','Location','southoutside','Interpreter','latex')
        saveas(gcf,'Figures/DLQR/circular_path_experimental_compensation_evaluation','epsc')

    end
end