function [norm_step_force] = data_normalization(step_time,step_force,plot_enable)

    for i = 1:length(step_time)
        if (plot_enable)
            figure
        end
        for j = 1:length(step_time{i})
    
                initial_samples = find(step_time{i}{j} <= 0.02);
                final_samples = find(step_time{i}{j} >= 0.5);
    
                initial_mean = mean(step_force{i}{j}(initial_samples));
                final_mean = mean(step_force{i}{j}(final_samples));
    
                norm_step_force{i}{j} = (step_force{i}{j} - initial_mean) / (final_mean - initial_mean);
    
                if (plot_enable)
                    plot(step_time{i}{j},norm_step_force{i}{j})
                    hold on
                end    
        end
        if (plot_enable)
            grid on
            xlabel('Time (s)','Interpreter','Latex')
            ylabel('Normalized Motor Thrust','Interpreter','Latex')
        end
    end
end
