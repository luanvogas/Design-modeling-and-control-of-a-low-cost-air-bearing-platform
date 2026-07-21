%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Design, modeling, and control of a low-cost air-bearing platform
%
% Software developed as part of the doctoral thesis.
%
% Author:      Luan Mateus Bocalan Vogás
% Advisor:     Prof. Dr. Roberto Kawakami Harrop Galvão
% Co-Advisor:  Profa. Dra. Gabriela Werner Gabriel
%
% Instituto Tecnológico de Aeronáutica (ITA)
% Electronics Engineering Division
% São José dos Campos, SP, Brazil
% 2026
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

%% Experimental Data Loading

% Calibration Data

plot_enable = 0;

[pressure_calibration, ...
 raw_calibration ...
] = calibration_data_loading(plot_enable);

% Air Bearing Characterization Data

[air_bearing_unpainted_time, ...
 air_bearing_unpainted_pressure, ...
 air_bearing_painted_time, ...
 air_bearing_painted_pressure ...
] = air_bearing_data_loading();

% Platform Characterization Data

[platform_input_time, ...
 platform_input_pressure, ...
 platform_output_time, ...
 platform_output_pressure ...
] = platform_data_loading();

%% Pressure Sensor Calibration

plot_enable = 0;

[a,b] = pressure_sensor_calibration(pressure_calibration, ...
                                    raw_calibration, ...
                                    plot_enable);

fprintf('Calibration: Raw = %.4f x Pressure + %.4f\n', a,b)

%% Plot of Air Bearing Characterization Data

plot_enable = 0;

air_bearing_characterization_data_plot(air_bearing_unpainted_time, ...
                                       air_bearing_unpainted_pressure, ...
                                       air_bearing_painted_time, ...
                                       air_bearing_painted_pressure, ...
                                       plot_enable)

%% Plot of Platform Characterization Data

plot_enable = 0;

platform_characterization_data_plot(platform_input_time, ...
                                                  platform_input_pressure, ...
                                                  platform_output_time, ...
                                                  platform_output_pressure, ...
                                                  plot_enable)






