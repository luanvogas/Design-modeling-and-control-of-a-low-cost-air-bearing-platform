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

%% Loading measurement data

[dataXAxis_x,dataXAxis_y,dataXAxis_angle,dataYAxis_x,dataYAxis_y,dataYAxis_angle] = data_loading();

%% Interpolation of experimental data

Fx = scatteredInterpolant(dataXAxis_x, dataXAxis_y, dataXAxis_angle);

Fy = scatteredInterpolant(dataYAxis_x, dataYAxis_y, dataYAxis_angle);

save('Matlab_Data\interpolants.mat','Fx','Fy')

%% Inclination map generation

[xqx, yqx] = meshgrid(-0.65:0.1:0.65, -0.65:0.1:0.65);
vqx = Fx(xqx, yqx);

[xqy, yqy] = meshgrid(-0.65:0.1:0.65, -0.65:0.1:0.65);
vqy = Fy(xqy, yqy);

edge_x = [0.75 0 -0.75 -0.75 -0.75 0 0.75 0.75 0.75];
edge_y = [0.75 0.75 0.75 0 -0.75 -0.75 -0.75 0 0.75];

lw = 1.5;
figure
set(gcf,'units','centimeters','position',[0,0,15,11])
quiver(xqx,yqx,vqx,vqy,'LineWidth',lw)
hold on
plot(edge_x,edge_y,'k','LineWidth',lw)
grid on
xlabel('x-axis (m)','Interpreter','latex')
ylabel('y-axis (m)','Interpreter','latex')
lgd = legend('Inclination','Glass edge','Interpreter','latex');
lgd.Location = 'southoutside';
saveas(gcf,'Figures\table_declivity','epsc')

%% Inclination map in the control experiment region

% Circular path
theta = linspace(0, 2*pi, 100);
xcp = 0.3 * cos(theta);
ycp = 0.3 * sin(theta);

% Plot

lw = 1.5;
figure
set(gcf,'units','centimeters','position',[0,0,15,11])
quiver(xqx,yqx,vqx,vqy,'LineWidth',lw)
hold on
plot(xcp,ycp,'LineWidth',lw)
grid on
xlabel('x-axis (m)','Interpreter','latex')
ylabel('y-axis (m)','Interpreter','latex')
legend('Inclination','Circular path','Interpreter','latex');
xlim([-0.4 0.4])
ylim([-0.4 0.4])
saveas(gcf,'Figures\circular_path_declivity','epsc')

%% Interpolation in two dimensions

resolution = 0.05;

xGrid = -0.65:resolution:0.65;
yGrid = -0.65:resolution:0.65;

for i = 1:length(xGrid)
    for j = 1:length(yGrid)
        incXAxis(i,j) = Fx(xGrid(i),yGrid(j));
        incYAxis(i,j) = Fy(xGrid(i),yGrid(j));
    end
end

%% Storing data to be read into the control code

csvwrite('Matlab_Data\xAxisInclinationGrid.csv', incXAxis);
csvwrite('Matlab_Data\yAxisInclinationGrid.csv', incYAxis);

save('Matlab_Data\inclinationGrid.mat','incXAxis','incYAxis');

%% Elevation determination 

contx = 0;
conty = 0;
for xp = -0.65:0.01:0.65
    contx = contx + 1;
    for yp = -0.65:0.01:0.65
        conty = conty + 1;
        h(contx,conty) = elevation(xp,yp,Fx,Fy);
    end
    conty = 0;
end

% 2D Plot

x = [-0.65 ; 0.65];
y = [-0.65 ; 0.65];

figure
set(gcf,'units','centimeters','position',[0,0,15,11])
imagesc(x,y,h')
set(gca, 'YDir', 'normal');
cbar = colorbar
cbar.Label.String = 'Elevation (m)';
cbar.Label.Interpreter = 'latex';
xlabel('x-axis (m)','Interpreter','latex')
ylabel('y-axis (m)','Interpreter','latex')
saveas(gcf,'Figures\elevation_heat_map','epsc')

% 3D Plot

figure
set(gcf,'units','centimeters','position',[0,0,15,11])
[X,Y] = meshgrid(-0.65:0.01:0.65,-0.65:0.01:0.65);
Z = h';
surf(X,Y,Z)
xlabel('x-axis (m)','Interpreter','latex')
ylabel('y-axis (m)','Interpreter','latex')
zlabel('Elevation (m)','Interpreter','latex')
saveas(gcf,'Figures\elevation_surface','epsc')



