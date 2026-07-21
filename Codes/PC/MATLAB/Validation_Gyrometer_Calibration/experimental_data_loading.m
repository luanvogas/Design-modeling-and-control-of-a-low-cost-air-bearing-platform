function [t_gyro,...
          x_gyro,...
          y_gyro,...
          z_gyro,...
          t_servo,...
          angle_servo] = experimental_data_loading()

    % Data loading
    
    filename = 'Experimental_Data/gyroscope_calibration_data_Test_8.csv';
    data = csvread(filename);
    
    % Data separation
    
    t = data(:,1);
    angle = data(:,2);
    x = data(:,3);
    y = data(:,4);
    z = data(:,5);
    
    separation = find(t == 1234) - 1;
    
    t_gyro = t(1:separation) - t(1);
    x_gyro = x(1:separation);
    y_gyro = y(1:separation);
    z_gyro = z(1:separation);
    
    t_servo = t(separation + 2:end) - t(separation + 2);
    angle_servo = angle(separation + 2:end);

end
