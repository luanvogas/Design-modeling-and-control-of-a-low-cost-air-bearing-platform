function [] = air_duct_comparison(pusher_time_air, ...
                                  pusher_force_air, ...
                                  tractor_time_air, ...
                                  tractor_force_air, ...
                                  pusher_time_ducted, ...
                                  pusher_force_ducted, ...
                                  tractor_time_ducted, ...
                                  tractor_force_ducted, ...
                                  plot_enable)
 
    if(plot_enable)

        % Pusher
        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        for i = 1:3
            pusher_plot_air{i} = plot(pusher_time_air{i},pusher_force_air{i},'LineWidth',lw);
            hold on
            pusher_plot_ducted{i} = plot(pusher_time_ducted{i},pusher_force_ducted{i},'LineWidth',lw);
        end
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Motor Thrust (N)','Interpreter','Latex')
        xlim([0 20])
        h = [pusher_plot_air{:} pusher_plot_ducted{:}];
        lgd = legend(h, ...
            'No duct - 45 mm - two blades','No duct - 45 mm - three blades',...
            'No duct - 55 mm','Ducted - 45 mm - two blades',...
            'Ducted - 45 mm - three blades','Ducted - 55 mm');
        
        lgd.NumColumns = 2;             
        lgd.Location = 'southoutside';   
        saveas(gcf,'Figures/pusher_propeller_comparison','epsc')

        % Tractor
        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        for i = 1:3
            tractor_plot_air{i} = plot(tractor_time_air{i},tractor_force_air{i},'LineWidth',lw);
            hold on
            tractor_plot_ducted{i} = plot(tractor_time_ducted{i},tractor_force_ducted{i},'LineWidth',lw);
        end
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Motor Thrust (N)','Interpreter','Latex')
        xlim([0 20])
        h = [tractor_plot_air{:} tractor_plot_ducted{:}];
        lgd = legend(h, ...
            'No duct - 45 mm - two blades','No duct - 45 mm - three blades',...
            'No duct - 55 mm','Ducted - 45 mm - two blades',...
            'Ducted - 45 mm - three blades','Ducted - 55 mm');
        
        lgd.NumColumns = 2;             
        lgd.Location = 'southoutside';  
        saveas(gcf,'Figures/tractor_propeller_comparison','epsc')    
    end
end