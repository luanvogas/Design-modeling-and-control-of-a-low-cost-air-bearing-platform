function [] = plot_raw_data(pusher_time, ...
                            pusher_force, ...
                            tractor_time, ...
                            tractor_force, ...
                            plot_enable)

    if(plot_enable)

        % Pusher mode
        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        for i = 1:length(pusher_time) 
            plot(pusher_time{i},pusher_force{i},'DisplayName', sprintf('Motor %d', i),'LineWidth',lw);
            hold on
        end        
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Motor Thrust (N)','Interpreter','Latex')
        xlim([0 220])
        lgd = legend('show');
        lgd.Interpreter = 'latex';
        lgd.Location = 'southoutside';
        lgd.Orientation = 'horizontal';
        saveas(gcf,'Figures/pusher_raw_force','epsc')

        % Tractor mode
        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        for i = 1:length(tractor_time)  
            plot(tractor_time{i},tractor_force{i},'DisplayName', sprintf('Motor %d', i),'LineWidth',lw);
            hold on
        end        
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Motor Thrust (N)','Interpreter','Latex')
        xlim([0 220])
        lgd = legend('show');
        lgd.Interpreter = 'latex';
        lgd.Location = 'southoutside';
        lgd.Orientation = 'horizontal';
        saveas(gcf,'Figures/tractor_raw_force','epsc')

    end
end