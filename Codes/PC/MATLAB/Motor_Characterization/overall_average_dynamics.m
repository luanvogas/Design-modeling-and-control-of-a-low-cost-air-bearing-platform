function [time,mean_dynamic_motors] = overall_average_dynamics(pusher_step_time, ...
                                                               pusher_mean_norm_step_force, ...
                                                               pusher_mode_mean_norm_step_force, ...
                                                               tractor_step_time, ...
                                                               tractor_mean_norm_step_force, ...
                                                               tractor_mode_mean_norm_step_force, ...
                                                               plot_enable)

    mean_pusher_dynamic = zeros(length(pusher_mean_norm_step_force{1}),1);
    counter = 0;

    for i = 1:length(pusher_mean_norm_step_force)
        counter = counter + 1;
        mean_pusher_dynamic = mean_pusher_dynamic + pusher_mean_norm_step_force{i};
    end

    mean_pusher_dynamic = mean_pusher_dynamic / counter;

    mean_tractor_dynamic = zeros(length(tractor_mean_norm_step_force{1}),1);
    counter = 0;

    for i = 1:length(tractor_mean_norm_step_force)
        counter = counter + 1;
        mean_tractor_dynamic = mean_tractor_dynamic + tractor_mean_norm_step_force{i};
    end

    mean_tractor_dynamic = mean_tractor_dynamic / counter;
    mean_dynamic_motors = (mean_pusher_dynamic + mean_tractor_dynamic) / 2;
    time = pusher_step_time{1}{1};

    save('Matlab_Data\dynamic_motors','time','mean_dynamic_motors')

    if(plot_enable)    
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(time,mean_pusher_dynamic,'b','LineWidth',1.5);
        hold on
        plot(time,mean_tractor_dynamic,'k','LineWidth',1.5);
        hold on
        plot(time,mean_dynamic_motors,'r','LineWidth',1.5);
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Normalized Motor Thrust','Interpreter','Latex')
        legend('Pusher mode','Tractor mode','Average profile','Location','best','Interpreter','latex')
        saveas(gcf,'Figures/overall_average_dynamics','epsc')
    end
end