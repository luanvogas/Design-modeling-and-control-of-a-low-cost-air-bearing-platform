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

% Suspended structure data

plot_enable = 0;

[time_raw,duty_raw,ang_speed_raw] = experimental_data_loading(plot_enable);

% Calibration data

plot_enable = 0;

[time_calibration,duty_calibration,ang_speed_calibration] = calibration_data_loading(plot_enable);

%% Data pre-processing

% Definition of the region of operation

plot_enable = 0;

experiment_time = 5;

sampling_time = 0.01; % Seconds

[time,duty,ang_speed_uncalibrated] = operation_region(time_raw, ...
                                                      duty_raw, ...
                                                      ang_speed_raw, ...
                                                      experiment_time, ...
                                                      sampling_time, ...
                                                      plot_enable);

% Calibration

plot_enable = 0;

[ang_speed,cal_factor] = calibration(time_calibration, ...
                                     ang_speed_calibration, ...
                                     time, ...
                                     ang_speed_uncalibrated, ...
                                     plot_enable);

cal_factor

%% Steady state values

plot_enable = 0;

[steady_state_duty,steady_state_ang_speed] = steady_state_values(time, ...
                                                                 duty, ...
                                                                 ang_speed, ...
                                                                 plot_enable);
%% Static modeling

plot_enable = 0;

[angular_coef] = static_modeling(steady_state_duty, ...
                                 steady_state_ang_speed, ...
                                 plot_enable)
%% Data normalization

plot_enable = 0;

[normalized_ang_speed] = data_normalization(time, ...
                                            ang_speed, ...
                                            steady_state_ang_speed, ...
                                            plot_enable);

%% Determination of average dynamics

plot_enable = 0;

[average_time,average_ang_speed] = average_dynamic(time, ...
                                                   normalized_ang_speed, ...
                                                   plot_enable);

%% Model identification

plot_enable = 0;

identification_enable = 0; % It can take a certain amount of time

if(identification_enable)

    [G_2_poles,step_sim_2_poles] = model_identification_2_poles(average_time, ...
                                                                average_ang_speed, ...
                                                                plot_enable);

    save('Matlab_Data\tf_2_poles','G_2_poles','step_sim_2_poles')

    [G_2_poles_1_zero,step_sim_2_poles_1_zero] = model_identification_2_poles_1_zero(average_time, ...
                                                                                     average_ang_speed, ...
                                                                                     plot_enable);

    save('Matlab_Data\tf_2_poles_1_zero','G_2_poles_1_zero','step_sim_2_poles_1_zero')

    [G_3_poles,step_sim_3_poles] = model_identification_3_poles(average_time, ...
                                                                average_ang_speed, ...
                                                                plot_enable);

    save('Matlab_Data\tf_3_poles','G_3_poles','step_sim_3_poles')

    [G_3_poles_1_zero,step_sim_3_poles_1_zero] = model_identification_3_poles_1_zero(average_time, ...
                                                                                     average_ang_speed, ...
                                                                                     plot_enable);

    save('Matlab_Data\tf_3_poles_1_zero','G_3_poles_1_zero','step_sim_3_poles_1_zero')

else
    load('Matlab_Data\tf_2_poles')

    load('Matlab_Data\tf_2_poles_1_zero')

    load('Matlab_Data\tf_3_poles')

    load('Matlab_Data\tf_3_poles_1_zero')
end

%% Model comparison

plot_enable = 0;

model_comparison(average_time, ...
                 average_ang_speed, ...
                 step_sim_2_poles, ...
                 step_sim_2_poles_1_zero, ...
                 step_sim_3_poles, ...
                 step_sim_3_poles_1_zero, ...
                 plot_enable)

%% Checking the model chosen

plot_enable = 1;

Grw = tf(G_3_poles_1_zero.num{1}*angular_coef,G_3_poles_1_zero.den{1})

model_simulation(Grw,time,ang_speed,plot_enable)

%% Data storage

% Data storage for controller design

save('Matlab_Data\reaction wheel_model','Grw')





















