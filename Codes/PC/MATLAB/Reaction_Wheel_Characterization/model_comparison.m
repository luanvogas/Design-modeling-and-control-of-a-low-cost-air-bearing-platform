function [] = model_comparison(average_time, ...
                               average_ang_speed, ...
                               step_sim_2_poles, ...
                               step_sim_2_poles_1_zero, ...
                               step_sim_3_poles, ...
                               step_sim_3_poles_1_zero, ...
                               plot_enable)

    if(plot_enable)
        lw = 1.5;
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(average_time,average_ang_speed,'k','LineWidth',lw)
        hold on
        plot(average_time,step_sim_2_poles,'LineWidth',lw)
        hold on
        plot(average_time,step_sim_2_poles_1_zero,'LineWidth',lw)
        hold on
        plot(average_time,step_sim_3_poles,'--','LineWidth',lw)
        hold on
        plot(average_time,step_sim_3_poles_1_zero,'-.','LineWidth',lw)
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Normalized Angular Velocity','Interpreter','latex')
        legend('Experimental data','Transfer function with 2 poles', 'Transfer function with 2 poles and 1 zero', ...
               'Transfer function with 3 poles','Transfer function with 3 poles and 1 zero','Location','Best',...
               'Interpreter','latex')
        xlim([0 5])
        axes('Position',[0.3 0.4 0.28 0.28]); % [left bottom width height]
        box on     
        plot(average_time,average_ang_speed,'k','LineWidth',lw)
        hold on
        plot(average_time,step_sim_2_poles,'LineWidth',lw)
        hold on
        plot(average_time,step_sim_2_poles_1_zero,'LineWidth',lw)
        hold on
        plot(average_time,step_sim_3_poles,'--','LineWidth',lw)
        hold on
        plot(average_time,step_sim_3_poles_1_zero,'-.','LineWidth',lw)
        grid on        
        xlim([0.0 0.2])
        ylim([-0.1 0.3])
        saveas(gcf,'Figures/model_comparison_rw','epsc')
    end
    
end