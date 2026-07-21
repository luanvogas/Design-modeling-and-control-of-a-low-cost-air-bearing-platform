function [time,duty,ang_speed] = operation_region(time_raw, ...
                                                  duty_raw, ...
                                                  ang_speed_raw, ...
                                                  experiment_time, ...
                                                  sampling_time, ...
                                                  plot_enable)
    index = 0;  
    for i = 1:length(time_raw)            
        if ((i ~= 6) && (i ~= 7) && (i ~= 8) && (i ~= 14) && (i ~= 15) && (i ~= 16))   
            index = index + 1;
            samples = 1:experiment_time/sampling_time;
            time{index} = time_raw{i}(samples);
            duty{index} = duty_raw{i}(samples);
            ang_speed{index} = ang_speed_raw{i}(samples);
        end    
    end
    if(plot_enable)
        blue = [0 0.4470 0.7410];
        orange = [0.8500 0.3250 0.0980];
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        lw = 1.5;
        for i = 1:index
            if(i <= 5)
                p1 = plot(time{i},ang_speed{i},'Color',blue,'LineWidth',lw);
            else
                p2 = plot(time{i},ang_speed{i},'Color',orange,'LineWidth',lw);
            end
            hold on
        end
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Angular Velocity ($\deg/$s)','Interpreter','latex')
        legend([p1,p2],{'Acceleration','Braking '},...
               'Location','southoutside','Orientation',...
               'horizontal','Interpreter','latex')
        xlim([0 5])
        saveas(gcf,'Figures/operation_region_rw','epsc')
    end

end
