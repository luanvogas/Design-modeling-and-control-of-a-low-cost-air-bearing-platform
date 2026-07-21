function [pressure_calibration, ...
          raw_calibration ...
         ] = calibration_data_loading(plot_enable)

    % Data Loading

    filename = 'Experimental_Data/Calibration/calibration_data.csv';
    data = csvread(filename);

    % Data separation 

    pressure = data(:,1);
    raw1 = data(:,2);
    raw2 = data(:,3);
    raw3 = data(:,4);

    % Data merging

    pressure_calibration = [pressure ; pressure ; pressure];
    raw_calibration = [raw1 ; raw2 ; raw3];

    % Data plot

    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(pressure_calibration,raw_calibration,'*','LineWidth',1.5)
        grid on
        xlabel('Air Pressure (psi)','Interpreter','latex')
        ylabel('ADC Raw Data','Interpreter','latex')
    end

end