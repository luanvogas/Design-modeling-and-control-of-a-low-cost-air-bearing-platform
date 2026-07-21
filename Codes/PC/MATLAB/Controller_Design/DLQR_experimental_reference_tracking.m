function [t_exp,...
          xmp_exp,...
          ymp_exp,...
          xcont_exp,...
          ycont_exp,...
          rot_ref_exp,...
          rot_exp,...
          rw_control] = DLQR_experimental_reference_tracking(t_dlqr_inc,...
                                                             x_ref_dlqr,...
                                                             y_ref_dlqr,...
                                                             xmp_dlqr_inc,...
                                                             ymp_dlqr_inc,...
                                                             xc_dlqr_inc,...
                                                             yc_dlqr_inc,...
                                                             tractor_max_force,...
                                                             plot_enable)

    

    %% Experimental data loading

    filename = 'Experimental_Data\control_data_DLQR_reference_tracking_uncompensated.csv';
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

    if(plot_enable)        

        %% Plot parameters
    
        lw = 1.5;       
        transparency = 0.2;
        blue_color  = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        yellow_color = [0.9290 0.6940 0.1250];    
        green_color = [0.4660 0.6740 0.1880];

        %% Displacement and control of individual axes
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,2)
        %
        nexttile  
        p1 = plot(t_dlqr_inc,xmp_dlqr_inc','Color',orange_color,'LineWidth',lw);
        hold on
        p2 = plot(t_exp,xmp_exp,'Color',yellow_color,'LineWidth',lw);
        grid on
        ylabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile  
        plot(t_dlqr_inc,ymp_dlqr_inc','Color',orange_color,'LineWidth',lw)
        hold on
        plot(t_exp,ymp_exp,'Color',yellow_color,'LineWidth',lw)
        grid on
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        xlim([0 60])
        %
        nexttile 
        plot_control_x = plot(t_exp,xcont_exp,'Color',green_color,'LineWidth',lw)
        plot_control_x.Color(4) = transparency;
        hold on    
        plot(t_dlqr_inc,xc_dlqr_inc,'Color',orange_color,'LineWidth',lw)
        hold on
        [t_exp_sm,xcont_exp_sm] = control_smoothing(t_exp,xcont_exp);
        p4 = plot(t_exp_sm,xcont_exp_sm,'Color',green_color,'LineWidth',lw);
        hold on        
        plot(t_dlqr_inc,tractor_max_force*ones(size(t_dlqr_inc)),'--k','LineWidth',lw)
        hold on
        plot(t_dlqr_inc,-tractor_max_force*ones(size(t_dlqr_inc)),'--k','LineWidth',lw)
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{xc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        ylim([-tractor_max_force,tractor_max_force])
        %
        nexttile 
        plot_control_y = plot(t_exp,ycont_exp,'Color',green_color,'LineWidth',lw)
        plot_control_y.Color(4) = transparency;
        hold on        
        plot(t_dlqr_inc,yc_dlqr_inc,'Color',orange_color,'LineWidth',lw)
        hold on
        [t_exp_sm,ycont_exp_sm] = control_smoothing(t_exp,ycont_exp);
        p5 = plot(t_exp_sm,ycont_exp_sm,'Color',green_color,'LineWidth',lw);
        hold on        
        plot(t_dlqr_inc,tractor_max_force*ones(size(t_dlqr_inc)),'--k','LineWidth',lw)
        hold on
        p3= plot(t_dlqr_inc,-tractor_max_force*ones(size(t_dlqr_inc)),'--k','LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$F_{yc}(t)$ (N)','Interpreter','latex')
        xlim([0 60])
        ylim([-tractor_max_force,tractor_max_force])
        %
        lgd = legend([p1,p2,plot_control_y,p5,p3],{'Simulation results','Experimental results','Force command (actual)','Force command (smoothed)','Saturation'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/experimental_result_without_compensation','epsc')

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
        plot(t_dlqr_inc,(1460+250)*ones(size(t_dlqr_inc)),'--k','LineWidth',lw)
        hold on
        p3= plot(t_dlqr_inc,(1460-250)*ones(size(t_dlqr_inc)),'--k','LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$u_{rwc}(t)$ ($\mu$s)','Interpreter','latex')
        xlim([0 60])
        ylim([1210 1710])
        lgd = legend([p1,p2,p3],{'Reference','Experimental results','Saturation bounds'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/experimental_result_rotation_without_compensation','epsc')

        %% 2D Reference Tracking 

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(x_ref_dlqr,y_ref_dlqr,'Color',blue_color,'LineWidth',lw);
        hold on
        plot(xmp_dlqr_inc,ymp_dlqr_inc,'Color',orange_color,'LineWidth',lw);
        hold on
        plot(xmp_exp,ymp_exp,'Color',yellow_color,'LineWidth',lw);
        grid on
        xlabel('$x_{cv}(t)$ (m)','Interpreter','latex')
        ylabel('$y_{cv}(t)$ (m)','Interpreter','latex')
        legend('Reference','Simulation result','Experimental result','Location',[0.385881642846781,0.461657708653586,0.2625518693565,0.115865382208274],'Interpreter','latex')
        saveas(gcf,'Figures/DLQR/circular_path_experimental_result_without_compensation','epsc')

    end
end