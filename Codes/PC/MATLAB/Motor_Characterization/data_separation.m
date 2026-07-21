function [step_time,step_duty,step_force] = data_separation(time,duty,force,plot_enable)
    if (plot_enable)
        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        color{1} = [0.0000, 0.4470, 0.7410];
        color{2} = [0.8500, 0.3250, 0.0980];
        color{3} = [0.9290, 0.6940, 0.1250];
        color{4} = [0.4940, 0.1840, 0.5560];
        color{5} = [0.4660, 0.6740, 0.1880];
        p = gobjects(1,length(time));  
        set(gcf,'Renderer','painters')
        set(gcf,'PaperUnits','centimeters')
        set(gcf,'PaperSize',[15 11])
        set(gcf,'PaperPosition',[0 0 15 11])
    end
    for i = 1:length(time)        
        index = 0;
        for j = 51:50:length(time{i})-50 % The start of the test is discarded  
            
            index = index + 1; 
            step_samples = j:j+49;
            step_time{i}{index} = time{i}(step_samples) - min(time{i}(step_samples));   
            step_duty{i}{index} = duty{i}(step_samples);   
            step_force{i}{index} = force{i}(step_samples);

            if (plot_enable)
                p(i) = plot(step_time{i}{index},step_force{i}{index},'Color',color{i},'LineWidth',lw);
                hold on
            end

        end
    end
    if (plot_enable)
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Motor Thrust (N)','Interpreter','Latex')        
        leg = arrayfun(@(k) sprintf('Motor %d',k), 1:length(time), ...
                            'UniformOutput', false);        
        legend(p, leg, ...
               'Location','southoutside', ...
               'Orientation','horizontal', ...
               'NumColumns', length(time))
        if (length(time) == 2)
            saveas(gcf,'Figures/separate_data_pusher','epsc')
        else
            saveas(gcf,'Figures/separate_data_tractor','epsc')
        end
    end
end
