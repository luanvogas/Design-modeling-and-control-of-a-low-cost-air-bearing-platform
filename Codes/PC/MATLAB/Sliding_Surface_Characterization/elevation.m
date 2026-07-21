function [h] = elevation(xp,yp,Fx,Fy)
    N = 10; 
    dx = xp/N; dy = yp/N;
    h = 0;
    xi = 0; yi = 0;
    for i = 1:N
        [anglex, angley] = angles(xi,yi,Fx,Fy);
        tanx = tand(anglex); tany = tand(angley);
        dhx = tanx*dx; dhy = tany*dy;
        h = h + dhx + dhy;
        xi = xi + dx; yi = yi + dy;
    end
end