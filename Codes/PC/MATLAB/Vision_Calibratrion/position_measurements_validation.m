function [x_adj,y_adj] = position_measurements_validation(glass_x,...
                                               glass_y,...
                                               plywood_x,...
                                               plywood_y,...
                                               plywood_division_x,...
                                               plywood_division_y,...
                                               x_central_useful, ...
                                               y_central_useful, ...
                                               x, ...
                                               y, ...
                                               plot_enable)

    % Colors 

    matlab_blue  = [0 0.4470 0.7410];

    % Plot of the raw data
    
    if(plot_enable)

        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(1,1)
        lw = 1.5;        
        nexttile;
        p1 = plot(glass_x,glass_y, 'b-','LineWidth', lw);
        hold on
        p2 = plot(plywood_x,plywood_y,'--k','LineWidth', lw);
        hold on
        plot(plywood_division_x,plywood_division_y,'--k','LineWidth', lw)
        hold on
        for i = 1:length(x)
            p3 = plot(x{i}(1),y{i}(1),'.','Color',matlab_blue,'LineWidth',lw);
            hold on
            plot(x{i}(2:end),y{i}(2:end),'.','Color',matlab_blue,'LineWidth',lw)
            hold on
        end
        p4 = plot(x_central_useful,y_central_useful,'+r','LineWidth',lw);
        axis equal
        grid on
        xlim([-0.8 0.8])
        ylim([-0.8 0.8])
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend([p1 p2 p3 p4],{'Glass edge', 'Plywood edge',...
                              'Collected data','Actual position'},...
                              'Location','southoutside','Orientation',...
                              'horizontal', 'NumColumns',2,'Interpreter',...
                              'latex')
        saveas(gcf,'Figures/raw_measured_position','epsc')
    end

    % Average of the data

    for i = 1:length(x)
        x_mean{i} = mean(x{i});
        y_mean{i} = mean(y{i});
    end
    
    % Adjustment of the data
    
    x_zero = x_mean{32};
    y_zero = y_mean{32};
    
    x_adj = [];
    y_adj = [];
    
    for i = 1:length(x_mean)
        x_adj = [x_adj ; x_mean{i} - x_zero];
        y_adj = [y_adj ; y_mean{i} - y_zero];
    end

    % Plot of the adjusted data

    if(plot_enable)          
        
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(1,1)
        lw = 1.5;        
        nexttile;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        p1 = plot(glass_x,glass_y, 'b-','LineWidth', lw);
        hold on
        p2 = plot(plywood_x,plywood_y,'--k','LineWidth', lw);
        hold on
        plot(plywood_division_x,plywood_division_y,'--k','LineWidth', lw)
        hold on
        p3 = plot(x_adj,y_adj,'*','Color',matlab_blue,'LineWidth',lw);
        hold on
        p4 = plot(x_central_useful,y_central_useful,'+r','LineWidth',lw);
        axis equal
        grid on
        xlim([-0.8 0.8])
        ylim([-0.8 0.8])
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend([p1 p2 p3 p4],{'Glass edge', 'Plywood edge',...
                              'Adjusted data',...
                              'Actual position'},...
                              'Location','southoutside','Orientation',...
                              'horizontal', 'NumColumns',2,'Interpreter',...
                              'latex')
        saveas(gcf,'Figures/zero_adjusted_measured_position','epsc')
    end
end