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

%% Data loading 

[t_gyro,...
 x_gyro,...
 y_gyro,...
 z_gyro,...
 t_servo,...
 angle_servo] = experimental_data_loading();

%% Servo data plot

plot_enable = 0;

servo_data_plot(t_servo,...
                angle_servo,...
                plot_enable);

%% Calculation of the angular velocity of the servo

servo_range_5s = find(t_servo <= 5);
t_servo_5s = t_servo(servo_range_5s);
angle_servo_5s = angle_servo(servo_range_5s);

[v_servo] = angular_velocity_determination(t_servo_5s,...
                                           angle_servo_5s);

%% Validation of gyroscope calibration

plot_enable = 0;

validation_gyroscope_calibration(t_gyro,...
                                 x_gyro,...
                                 y_gyro,...
                                 z_gyro,...
                                 t_servo_5s,...
                                 v_servo,...
                                 plot_enable)




