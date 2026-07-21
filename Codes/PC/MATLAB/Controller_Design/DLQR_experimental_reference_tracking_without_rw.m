function [] = DLQR_experimental_reference_tracking_without_rw(t_dlqr_inc,...
                                                              xmp_dlqr_inc,...
                                                              ymp_dlqr_inc,...
                                                              plot_enable)

    

    %% Experimental data loading

    filename = 'Experimental_Data\control_data_DLQR_ref_track_uncompensated_without_rw.csv';
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
        tiledlayout(3,1)
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
        plot(t_exp,rot_exp,'Color',yellow_color,'LineWidth',lw);
        grid on
        xlabel('$t$ (s)','Interpreter','latex')
        ylabel('$\theta_{p_{cv}}(t)$ ($\deg$)','Interpreter','latex')
        xlim([0 60])
        lgd = legend([p1,p2],{'Simulation results','Experimental results'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/DLQR/experimental_result_without_comp_and_rw_control','epsc')    
    end
end