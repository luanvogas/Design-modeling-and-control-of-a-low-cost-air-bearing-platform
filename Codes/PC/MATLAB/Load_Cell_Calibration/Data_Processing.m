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

% Data loading

filename = 'Experimental_data/data.csv';
data = csvread(filename);

% Data separation

p = data(:,1);
l1 = data(:,2);
l2 = data(:,3);
l3 = data(:,4);
l4 = data(:,5);
l5 = data(:,6);

% Data processing

p_total = [p ; p ; p ; p ; p];
l_total = [l1 ; l2 ; l3 ; l4 ; l5];

polinomio = polyfit(p_total,l_total,1);

a = polinomio(1)
b = polinomio(2) 

% Data plot

lw = 1.5;

figure
set(gcf,'units','centimeters','position',[0,0,15,11])
plot([0 1000],a*[0 1000]+b,'b','LineWidth',lw)
hold on
plot(p,l1,'+r','LineWidth',lw)
hold on
plot(p,l2,'+r','LineWidth',lw)
hold on
plot(p,l3,'+r','LineWidth',lw)
hold on
plot(p,l4,'+r','LineWidth',lw)
hold on
plot(p,l5,'+r','LineWidth',lw)
grid on
xlabel('Mass (g)','Interpreter','Latex')
ylabel('HX711 Raw Data','Interpreter','Latex')
legend('Fitted curve','Collected data','Location','Best','Interpreter','Latex')

saveas(gcf,'Figures/load_cell_calibration_data','epsc')






