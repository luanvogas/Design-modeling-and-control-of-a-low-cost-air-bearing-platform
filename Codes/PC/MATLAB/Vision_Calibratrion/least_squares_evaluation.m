function [] = least_squares_evaluation(glass_x,...
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

    % Simplification in variable names 

    x_g = x_central_useful;
    y_g = y_central_useful;
    x_a = x_adj;
    y_a = y_adj;
    
    % Adjustment grid
    
    x_ag = [x_g(1:10) ; x_g(12) ; x_g(14) ; x_g(16) ; x_g(18:20) ; x_g(22) ; ...
            x_g(24) ; x_g(26:28) ; x_g(30) ; x_g(32) ; x_g(34) ; x_g(36:38); ...
            x_g(40) ; x_g(42) ; x_g(44:46) ; x_g(48) ; x_g(50) ; x_g(52) ; ...
            x_g(54:end)];
    
    y_ag = [y_g(1:10) ; y_g(12) ; y_g(14) ; y_g(16) ; y_g(18:20) ; y_g(22) ; ...
            y_g(24) ; y_g(26:28) ; y_g(30) ; y_g(32) ; y_g(34) ; y_g(36:38); ...
            y_g(40) ; y_g(42) ; y_g(44:46) ; y_g(48) ; y_g(50) ; y_g(52) ; ...
            y_g(54:end)];
    
    
    % Adjustment data
    
    x_ls = [x_a(1:10) ; x_a(12) ; x_a(14) ; x_a(16) ; x_a(18:20) ; x_a(22) ; ...
            x_a(24) ; x_a(26:28) ; x_a(30) ; x_a(32) ; x_a(34) ; x_a(36:38); ...
            x_a(40) ; x_a(42) ; x_a(44:46) ; x_a(48) ; x_a(50) ; x_a(52) ; ...
            x_a(54:end)];
    
    y_ls = [y_a(1:10) ; y_a(12) ; y_a(14) ; y_a(16) ; y_a(18:20) ; y_a(22) ; ...
            y_a(24) ; y_a(26:28) ; y_a(30) ; y_a(32) ; y_a(34) ; y_a(36:38); ...
            y_a(40) ; y_a(42) ; y_a(44:46) ; y_a(48) ; y_a(50) ; y_a(52) ; ...
            y_a(54:end)];
    
    % Validation data
    
    x_vd = [x_a(11) ; x_a(13) ; x_a(15) ; x_a(17) ; x_a(21) ; x_a(23) ; ...
            x_a(25) ; x_a(29) ; x_a(31) ; x_a(33) ; x_a(35) ; x_a(39) ; ...
            x_a(41) ; x_a(43) ; x_a(47) ; x_a(49) ; x_a(51) ; x_a(53)];
    
    y_vd = [y_a(11) ; y_a(13) ; y_a(15) ; y_a(17) ; y_a(21) ; y_a(23) ; ...
            y_a(25) ; y_a(29) ; y_a(31) ; y_a(33) ; y_a(35) ; y_a(39) ; ...
            y_a(41) ; y_a(43) ; y_a(47) ; y_a(49) ; y_a(51) ; y_a(53)];
    
    % Least squares adjustment
    
    Xm = x_ag';
    Ym = y_ag';
    
    Thetac = [x_ls' ; y_ls' ; ones(size(x_ls'))]; 
    
    Ahatx = Xm * Thetac' / (Thetac * Thetac');
    Ahaty = Ym * Thetac' / (Thetac * Thetac');
    
    % Calculation of estimated position values
    
    x_est = Ahatx * Thetac;
    y_est = Ahaty * Thetac;
    
    % Check of the result
    
    Thetac_ck = [x_vd' ; y_vd' ; ones(size(x_vd'))]; 
    
    x_ck = Ahatx * Thetac_ck;
    y_ck = Ahaty * Thetac_ck;
    
    % Plot of the results

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
        p4 = plot(x_g,y_g,'r+','LineWidth',lw);
        hold on
        p5 = plot(x_ck,y_ck,'x','Color',matlab_yellow,'LineWidth',lw);
        axis equal
        grid on
        xlim([-0.8 0.8])
        ylim([-0.8 0.8])
        xlabel('x-axis (m)','Interpreter','latex')
        ylabel('y-axis (m)','Interpreter','latex')
        legend([p1 p2 p3 p4 p5],{'Glass edge', 'Plywood edge',...
                              'Data used in the LS procedure',...
                              'Actual position',...
                              'Data used for test'},...                              
                              'Location','southoutside','Orientation',...
                              'horizontal', 'NumColumns',2,'Interpreter',...
                              'latex')
        saveas(gcf,'Figures/least_square_methode_validation','epsc')

    end
end