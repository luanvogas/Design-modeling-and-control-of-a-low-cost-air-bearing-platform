%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Design, modeling, and control of a low-cost air-bearing platform
%
% Software developed throughout the doctoral thesis.
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

% Data loading

filename = 'Experimental_Data/camera_delay_data.csv';
data = csvread(filename);

% Data separation

t = data(:,1);
angle = data(:,2);
x = data(:,3);
y = data(:,4);

separation = find(t == 1234) - 1;

cameraTime = t(1:separation) - t(1);
cameraAngle = angle(1:separation) - mean(angle(1:50));

servoTime = t(separation + 2:end) - t(separation + 2);
servoAngle = angle(separation + 2:end);

% Data plot

lw = 1.5;  
figure
set(gcf,'units','centimeters','position',[0,0,15,11])
plot(cameraTime, cameraAngle,'LineWidth',lw);
hold on
plot(servoTime,servoAngle,'LineWidth',lw);
xlim([0 20])
grid on
xlabel('Time (s)','Interpreter','Latex')
ylabel('Amplitude ($\deg$)','Interpreter','Latex')
legend('Camera Data','Servo Data','Interpreter','latex','Location','best') 

% Zoom plot

axes('Position',[0.45 0.16 0.25 0.15]) % [x y width height]
box on
plot(cameraTime, cameraAngle,'LineWidth',lw);
hold on
plot(servoTime,servoAngle,'LineWidth',lw);
grid on
xlim([16.2 16.4])
ylim([-60 -20])

% Delay validation

figure
set(gcf,'units','centimeters','position',[0,0,15,11/2])
tiledlayout(1,2)
%
nexttile  
interpTime = 0:0.01:20;
servoInterpAngle  = interp1(servoTime,  servoAngle, interpTime, 'linear');
cameraInterpAngle = interp1(cameraTime, cameraAngle, interpTime, 'linear');
plot(servoInterpAngle,cameraInterpAngle,'.','LineWidth',lw);
hold on
plot(-120:40,-120:40,'r','LineWidth',lw)
grid on
xlabel('Servo Data ($\deg$)','Interpreter','Latex')
ylabel('Camera Data ($\deg$)','Interpreter','Latex')
%
nexttile
interpTime = 0:0.0001:20;
servoInterpAngle  = interp1(servoTime,  servoAngle, interpTime, 'linear');
cameraInterpAngle = interp1(cameraTime, cameraAngle, interpTime, 'linear');
i=-521;
servoInterpAngleDelayed = servoInterpAngle(1001+i:end-1001+i);
time = interpTime(1001:end-1001);
cameraData = cameraInterpAngle(1001:end-1001);
plot(servoInterpAngleDelayed,cameraData,'.','LineWidth',lw)
hold on
plot(-120:40,-120:40,'r','LineWidth',lw)
grid on
xlabel('Delayed Servo Data ($\deg$)','Interpreter','Latex')
saveas(gcf,'Figures/delay_validation','epsc')



