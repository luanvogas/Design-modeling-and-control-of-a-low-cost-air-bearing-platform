function [a_p,b_p,c_sl,d_sl,transition,best_transition,J,best_J,x_plot,y_plot] = motor_best_fit(step_duty,step_m)

transition = 10:5:45;

best_J = 1000;

for i = 1:length(transition)

    tp = max(find(step_duty == transition(i)));
    
    duty_par = step_duty(1:tp);
    
    duty_line = step_duty(tp:end);
    
    ss_par = step_m(1:tp);
    
    ss_line = step_m(tp:end);
    
    [a,b,c,d,J(i)] = first_second_orders_least_square(duty_par,ss_par,duty_line,ss_line); 

    if (J(i) <= best_J)
        best_transition = transition(i);
        best_J = J(i);
        a_p = a;
        b_p = b;
        c_sl = c;
        d_sl = d;
    end
end

f = @(x)a_p*x.^2+b_p*x;

x_par = linspace(0,best_transition,1000);
y_par = f(x_par);

f = @(x)c_sl*x+d_sl; 

x_line = [best_transition 50];
y_line = f(x_line);

x_plot = [x_par x_line];
y_plot = [y_par y_line];

end
