function [Fincx,Fincy] = calculate_inclination_force(x_pos,y_pos)

    persistent Fx Fy
    
    if isempty(Fx)
        data = load('Matlab_data/interpolants.mat');
        Fx = data.Fx;
        Fy = data.Fy;
    end
    
    m = 1220.24/1000; % kg
    g = 9.8066; % m/s^2
    
    anglex = Fx(x_pos,y_pos);
    angley = Fy(x_pos,y_pos);
    
    Fincx = (m*g) * sind(anglex);
    Fincy = (m*g) * sind(angley);

end