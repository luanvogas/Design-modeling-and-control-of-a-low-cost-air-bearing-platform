function [normalized_ang_speed] = data_normalization(time, ...
                                                     ang_speed, ...
                                                     steady_state_ang_speed, ...
                                                     plot_enable)
    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        blue = [0 0.4470 0.7410];
        orange = [0.8500 0.3250 0.0980];
    end

    for i = 1:length(time)
        normalized_ang_speed{i} = ang_speed{i}/steady_state_ang_speed(i);

        if(plot_enable)
            if(i <= 5)
                plot_color = blue;
            else
                plot_color = orange;
            end
            p{i} = plot(time{i},normalized_ang_speed{i},'Color',plot_color,'LineWidth',1.5);
            hold on
        end
    end

    if(plot_enable)
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Normalized Angular Velocity','Interpreter','latex')
        legend([p{1},p{6}],{'Acceleration','Braking'},...
               'Location','best','Interpreter','latex')
        xlim([0 5])
        saveas(gcf,'Figures/normalized_angular_velocity','epsc')
    end
end