function [a,b] = pressure_sensor_calibration(pressure_calibration, ...
                                             raw_calibration, ...
                                             plot_enable)

    % Least Squares Adjustment 

    polynomial  = polyfit(pressure_calibration,raw_calibration,1);
    identified_model = polyval(polynomial,[100:-5:5]);
    
    a = polynomial(1);    
    b = polynomial(2); 

    % Plot 
    
    if(plot_enable)
        lw = 1.5;    
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot([0 100],a*[0 100]+b,'b','LineWidth',lw)
        hold on
        plot(pressure_calibration,raw_calibration,'+r','LineWidth',lw)
        grid on
        ax = gca;
        ax.YTickLabel{1} = '';
        xlabel('Air Pressure (psi)','Interpreter','Latex')
        ylabel('ADC Raw Data','Interpreter','Latex')
        legend('Fitted line','Collected data','Location','Best','Interpreter','Latex')        
        saveas(gcf,'Figures/LS_Pressure_Sensor','epsc')
    end   

end