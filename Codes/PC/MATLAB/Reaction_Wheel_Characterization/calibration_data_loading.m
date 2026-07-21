function [time_calibration,duty_calibration,ang_speed_calibration] = calibration_data_loading(plot_enable)

    index = 0;
    
    % Test 5
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_calibration_data_Test_5.csv';
    data = csvread(filename);
    
    time_calibration{index} = data(:,1);
    duty_calibration{index} = data(:,2);
    ang_speed_calibration{index} = data(:,5);
    
    % Test 13
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_calibration_data_Test_13.csv';
    data = csvread(filename);
    
    time_calibration{index} = data(:,1);
    duty_calibration{index} = data(:,2);
    ang_speed_calibration{index} = data(:,5);
    
    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        lw = 1.5;
        for i = 1:index
            plot(time_calibration{i},ang_speed_calibration{i},'LineWidth',lw)
            hold on
        end
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Angular Velocity ($\deg/$s)','Interpreter','latex')
        legend('Acceleration','Braking','Interpreter','latex','Location','best')
        xlim([0 20])
        saveas(gcf,'Figures/calibration_data_rw','epsc')
    end

end
