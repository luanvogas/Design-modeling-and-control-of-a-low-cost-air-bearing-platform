function [air_bearing_unpainted_time, ...
          air_bearing_unpainted_pressure, ...
          air_bearing_painted_time, ...
          air_bearing_painted_pressure ...
         ] = air_bearing_data_loading()

    %% Unpainted data

    index = 0;

    % 60 psi

    filename = 'Experimental_Data/Air_bearing/data_60_up.csv';
    data = csvread(filename); 

    index = index + 1;
    air_bearing_unpainted_time{index} = data(:,1);
    air_bearing_unpainted_pressure{index} = data(:,2);

    % 70 psi

    filename = 'Experimental_Data/Air_bearing/data_70_up.csv';
    data = csvread(filename); 

    index = index + 1;
    air_bearing_unpainted_time{index} = data(:,1);
    air_bearing_unpainted_pressure{index} = data(:,2);

    % 80 psi

    filename = 'Experimental_Data/Air_bearing/data_80_up.csv';
    data = csvread(filename); 

    index = index + 1;
    air_bearing_unpainted_time{index} = data(:,1);
    air_bearing_unpainted_pressure{index} = data(:,2);

    %% Painted data

    index = 0;

    % 60 psi

    filename = 'Experimental_Data/Air_bearing/data_60_p.csv';
    data = csvread(filename); 

    index = index + 1;
    air_bearing_painted_time{index} = data(:,1);
    air_bearing_painted_pressure{index} = data(:,2);

    % 70 psi

    filename = 'Experimental_Data/Air_bearing/data_70_p.csv';
    data = csvread(filename); 

    index = index + 1;
    air_bearing_painted_time{index} = data(:,1);
    air_bearing_painted_pressure{index} = data(:,2);

    % 80 psi

    filename = 'Experimental_Data/Air_bearing/data_80_p.csv';
    data = csvread(filename); 

    index = index + 1;
    air_bearing_painted_time{index} = data(:,1);
    air_bearing_painted_pressure{index} = data(:,2);

end