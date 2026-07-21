function [anglex,angley] = angles(x,y,Fx,Fy)
    anglex = -Fx(x,y);
    angley = -Fy(x,y);
end