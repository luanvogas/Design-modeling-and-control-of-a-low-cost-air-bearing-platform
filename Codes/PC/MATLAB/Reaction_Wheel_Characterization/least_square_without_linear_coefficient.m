function [a] = least_square_without_linear_coefficient(x,y)

% y = ax

a = (y'*x) / (x'*x);

end
