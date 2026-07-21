function [a,b,c,d,J] = first_second_orders_least_square(x_N1_1,y_N1,x_N2_1,y_N2)

x_N1_2 = x_N1_1.^2;

x_N0_1 = x_N1_1(end) * ones(size(x_N2_1));

x0 = x_N1_1(end);

x_N0_2 = x_N0_1.^2;

A_N1 = [x_N1_2 x_N1_1 zeros(size(x_N1_1))];

A_N2 = [x_N0_2 x_N0_1 (-x_N0_1 + x_N2_1)];

Theta = (A_N1'*A_N1 + A_N2'*A_N2)\(A_N1'*y_N1 + A_N2'*y_N2);

a = Theta(1,1);

b = Theta(2,1);

c = Theta(3,1);

d = a*x0^2 + b*x0 - c*x0;

J = (y_N1 - A_N1 * Theta)' * (y_N1 - A_N1 * Theta) + ...
    (y_N2 - A_N2 * Theta)' * (y_N2 - A_N2 * Theta);

end