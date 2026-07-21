function [x_central_useful,...
          y_central_useful] = central_position_template(glass_x,...
                                        glass_y,...
                                        plywood_x,...
                                        plywood_y,...
                                        plywood_division_x,...
                                        plywood_division_y,...
                                        nut_x,...
                                        nut_y,...
                                        plot_enable)
    % Central positions

    x_central_useful = [];
    y_central_useful = [];

    for y = 0.15*3:-0.15:-0.15*3
        for x = -0.15*4:0.15:0.15*4    
            x_central_useful = [x_central_useful ; x];  
            y_central_useful = [y_central_useful ; y];
        end
    end

    x_central_useful_discarded = [[-0.15*4:0.15:0.15*4] [-0.15*4:0.15:0.15*4]];
    y_central_useful_discarded = [0.15*4*ones(1,9) -0.15*4*ones(1,9)];    

    if(plot_enable)

        % Colors 

        matlab_blue  = [0 0.4470 0.7410];
        matlab_yellow = [0.9290 0.6940 0.1250];
       
        % Complete plot

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
        p3 = plot(nut_x,nut_y,'xr','LineWidth', lw);
        hold on
        p4 = plot(x_central_useful,y_central_useful,'+','Color',matlab_blue,'LineWidth', lw);
        hold on 
        p5 = plot(x_central_useful_discarded,y_central_useful_discarded,'+','Color',matlab_yellow,'LineWidth', lw);
        axis equal
        grid on
        xlim([-0.8 0.8])
        ylim([-0.8 0.8])
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend([p1,p2,p3,p4,p5], ...
               {'Glass edge', 'Plywood edge', 'Insert nuts', ...
                'Useful positions', 'Discarded positions'}, ...
                'Location','southoutside','Orientation','horizontal', ...
                 'NumColumns',2,'Interpreter','latex');
        saveas(gcf,'Figures/position_template_representation','epsc')

        % Useful central positions plot

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
        p3 = plot(x_central_useful,y_central_useful,'+','Color',matlab_blue,'LineWidth', lw);
        axis equal
        grid on
        xlim([-0.8 0.8])
        ylim([-0.8 0.8])
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend([p1,p2,p3], ...
               {'Glass edge', 'Plywood edge','Useful positions'}, ...
                'Location','southoutside','Orientation','horizontal', ...
                 'Interpreter','latex');
        saveas(gcf,'Figures/useful_position_template','epsc')

    end
end