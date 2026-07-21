function [mean_norm_step_force,...
          mode_mean_norm_step_force] = average_dynamic(norm_step_force, ...
                                                       step_time, ...
                                                       plot_enable)
    
    counter1 = 0;
    mode_mean_norm_step_force = zeros(length(norm_step_force{1}{1}),1);
    for i = 1:length(norm_step_force)
        counter2 = 0;
        mean_norm_step_force{i} = zeros(length(norm_step_force{i}{1}),1);
        for j = 1:length(norm_step_force{i})
            counter2 = counter2 + 1;
            mean_norm_step_force{i} = mean_norm_step_force{i} + norm_step_force{i}{j};
        end
        mean_norm_step_force{i} = mean_norm_step_force{i} / counter2;

        counter1 = counter1 + 1;
        mode_mean_norm_step_force = mode_mean_norm_step_force + mean_norm_step_force{i};
    end
    mode_mean_norm_step_force = mode_mean_norm_step_force / counter1;    

    if (plot_enable)

        lw = 1.5;
        figure
        set(gcf,'units','centimeters','position',[0,0,15,4*length(norm_step_force)])
        set(gcf,'Renderer','painters')
        set(gcf,'PaperUnits','centimeters')
        set(gcf,'PaperSize',[15 4*length(norm_step_force)])
        set(gcf,'PaperPosition',[0 0 15 4*length(norm_step_force)])
        tiledlayout(length(norm_step_force),1)
        for i = 1:length(norm_step_force)
            nexttile 
            for j = 1:length(norm_step_force{i})
                p1 = plot(step_time{i}{j},norm_step_force{i}{j},'b','LineWidth',1.5);
                hold on
            end
            p2 = plot(step_time{i}{1},mean_norm_step_force{i},'r','LineWidth',1.5);            
            grid on
            ylabel({sprintf('Motor %d ', i),'Norm. Thrust (N)'}, ...
                   'Interpreter','latex');

        end
        xlabel('Time (s)','Interpreter','Latex')
        lgd = legend([p1,p2],{'Normalized data','Average profile'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        if(max(length(norm_step_force)) == 2)
            saveas(gcf,'Figures/average_dynamic_pusher','epsc')
        else
            saveas(gcf,'Figures/average_dynamic_tractor','epsc')
        end

    end
end
