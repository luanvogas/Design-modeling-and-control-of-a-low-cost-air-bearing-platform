function [platform_input_time, ...
          platform_input_pressure, ...
          platform_output_time, ...
          platform_output_pressure ...
         ] = platform_data_loading()

    %% Pressure at the regulator input 

    index = 0;

    filename = 'Experimental_Data/Platform/Input_Pressure_Regulator/data_V1.csv';
    data = csvread(filename); 

    index = index + 1;
    platform_input_time{index} = data(:,1);
    platform_input_pressure{index} = data(:,2);

    filename = 'Experimental_Data/Platform/Input_Pressure_Regulator/data_V2.csv';
    data = csvread(filename); 

    index = index + 1;
    platform_input_time{index} = data(:,1);
    platform_input_pressure{index} = data(:,2);

    filename = 'Experimental_Data/Platform/Input_Pressure_Regulator/data_V3.csv';
    data = csvread(filename); 

    index = index + 1;
    platform_input_time{index} = data(:,1);
    platform_input_pressure{index} = data(:,2);

    %% Pressure at the regulator output  

    index = 0;

    filename = 'Experimental_Data/Platform/Output_Pressure_Regulator/data_V1.csv';
    data = csvread(filename); 

    index = index + 1;
    platform_output_time{index} = data(:,1);
    platform_output_pressure{index} = data(:,2);

    filename = 'Experimental_Data/Platform/Output_Pressure_Regulator/data_V2.csv';
    data = csvread(filename); 

    index = index + 1;
    platform_output_time{index} = data(:,1);
    platform_output_pressure{index} = data(:,2);

    filename = 'Experimental_Data/Platform/Output_Pressure_Regulator/data_V3.csv';
    data = csvread(filename); 

    index = index + 1;
    platform_output_time{index} = data(:,1);
    platform_output_pressure{index} = data(:,2);

end