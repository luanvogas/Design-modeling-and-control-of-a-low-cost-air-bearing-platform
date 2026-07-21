function [dataXAxis_x,dataXAxis_y,dataXAxis_angle,dataYAxis_x,dataYAxis_y,dataYAxis_angle] = data_loading()

    % x-axis
    
    filename = 'Experimental_Data\inclination_check_x.csv';
    data = csvread(filename);
    rawX = data(1:end-1,:);   

    dataXAxis_x = rawX(:,1);
    dataXAxis_y = rawX(:,2);
    dataXAxis_angle = -rawX(:,3);
    
    % y-axis
    
    filename = 'Experimental_Data\inclination_check_y.csv';
    data = csvread(filename);
    rawY = data(1:end-1,:);   
    
    dataYAxis_x = rawY(:,1);
    dataYAxis_y = rawY(:,2);
    dataYAxis_angle = -rawY(:,3);

end