function [glass_x,...
          glass_y,...
          plywood_x,...
          plywood_y,...
          plywood_division_x,...
          plywood_division_y,...
          nut_x,...
          nut_y] = plywood_template_representation(plot_enable)

    % Dimensions of the glass side 

    gs = 1.5;
    gs2 = gs/2;

    % Representation of the edges of the glass table

    glass_x = [gs2 -gs2 -gs2 gs2 gs2]; 
    glass_y = [gs2 gs2 -gs2 -gs2 gs2];

    % Representation of plywood boards

    plywood_x = [gs2-0.005 -gs2+0.005 -gs2+0.005 gs2-0.005 gs2-0.005];
    plywood_y = [gs2-0.005 gs2-0.005 -gs2+0.005 -gs2+0.005 gs2-0.005];

    plywood_division_x = [0 0];
    plywood_division_y = [gs2-0.005 -gs2+0.005];

    % Distribution of insert nuts 

    nut_x = [];
    nut_y = [];

    for i = -gs2+0.075 : 0.15 : gs2-0.075
        for j = gs2-0.075 : -0.15 : -gs2+0.075
            nut_x = [nut_x ; i];
            nut_y = [nut_y ; j];
        end
    end

    % Plot

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
        p3 = plot(nut_x,nut_y,'xr','LineWidth', lw);
        axis equal
        grid on
        xlim([-0.8 0.8])
        ylim([-0.8 0.8])
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend([p1,p2,p3], ...
               {'Glass edge', 'Plywood edge', 'Insert nuts'}, ...
                'Location','southoutside','Orientation','horizontal', ...
                'Interpreter','latex');
        saveas(gcf,'Figures/plywood_template_representation','epsc')
    end
end