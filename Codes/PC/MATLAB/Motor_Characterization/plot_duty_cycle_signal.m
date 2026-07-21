function [] = plot_duty_cycle_signal(pusher_time, ...
                                     pusher_duty, ...
                                     plot_enable)

    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(pusher_time{1},pusher_duty{1},'LineWidth',1.5);
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Duty Cycle (\%)','Interpreter','Latex')
        xlim([0 220])
        saveas(gcf,'Figures/duty_cycle_signal','epsc')

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(pusher_time{1},pusher_duty{1},'LineWidth',1.5);
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Duty Cycle (\%)','Interpreter','Latex')
        xlim([0 20])
        saveas(gcf,'Figures/duty_cycle_signal_thrust_generation_test','epsc')
    end
end
