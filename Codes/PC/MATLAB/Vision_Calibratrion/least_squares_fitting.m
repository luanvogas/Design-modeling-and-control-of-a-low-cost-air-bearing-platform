function [Ahatx,Ahaty] = least_squares_fitting(glass_x,...
                                               glass_y,...
                                               plywood_x,...
                                               plywood_y,...
                                               plywood_division_x,...
                                               plywood_division_y,...
                                               x_central_useful, ...
                                               y_central_useful, ...
                                               x_adj, ...
                                               y_adj, ...
                                               plot_enable)

    % Least squares fitting
    
    Xm = x_central_useful;
    Ym = y_central_useful;
    
    Thetac = [x_adj y_adj ones(size(x_adj))]; 
    
    Ahatx = (Thetac' * Thetac) \ Thetac' * Xm;
    Ahaty = (Thetac' * Thetac) \ Thetac' * Ym;
    
    % Calculation of estimated position values
    
    x_est = Thetac * Ahatx;
    y_est = Thetac * Ahaty;
    
    %% Plot of the results

    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(1,1)
        lw = 1.5;        
        nexttile;
        matlab_yellow = [0.9290 0.6940 0.1250];
        p1 = plot(glass_x,glass_y, 'b-','LineWidth', lw);
        hold on
        p2 = plot(plywood_x,plywood_y,'--k','LineWidth', lw);
        hold on
        plot(plywood_division_x,plywood_division_y,'--k','LineWidth', lw)
        hold on
        p3 = plot(x_est,y_est,'b*','LineWidth',lw);
        hold on
        p4 = plot(x_central_useful,y_central_useful,'r+','LineWidth',lw);
        axis equal
        grid on
        xlim([-0.8 0.8])
        ylim([-0.8 0.8])
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend([p1 p2 p3 p4],{'Glass edge', 'Plywood edge',...
                              'Calibrated data',...
                              'Actual position'},...                              
                              'Location','southoutside','Orientation',...
                              'horizontal', 'NumColumns',2,'Interpreter',...
                              'latex')
        saveas(gcf,'Figures/least_square_methode_fitting','epsc') 
    end
end