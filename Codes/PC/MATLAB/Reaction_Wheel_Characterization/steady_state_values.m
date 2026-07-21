function [steady_state_duty,steady_state_ang_speed] = steady_state_values(time, ...
                                                                          duty, ...
                                                                          ang_speed, ...
                                                                          plot_enable)

    steady_state_duty = [];
    steady_state_ang_speed = [];

    intermediate_duty_cycle = 1460;

    for i = 1:length(time)
        final_samples = find(time{i} >= 4);

        steady_state_duty = [steady_state_duty ; mean(duty{i}(final_samples)) - intermediate_duty_cycle];
        steady_state_ang_speed = [steady_state_ang_speed ; mean(ang_speed{i}(final_samples))];           
    end

    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(steady_state_duty,steady_state_ang_speed,'*','LineWidth',1.5);
        grid on
        xlabel(' Duty Cycle Variation ($\mu$s)','Interpreter','Latex')
        ylabel('Angular Speed ($\deg/$s)','Interpreter','latex')
    end
end