function RMSE = find_motor_model(x)    

    tau = x(1);
    ta = x(2);
    
    load('Matlab_Data\dynamic_motors.mat')

    s = tf('s');
    
    Ts = time;
    
    yobs = mean_dynamic_motors;  

    Gm = tf(1,[tau 1]) * exp(-s*ta);
            
    for l = 2:size(Ts,1)
        sim = step(Gm,[0 Ts(l)]);
        ypred(1) = sim(1);
        ypred(l) = sim(end);
    end

    sum_error = 0;

    for m = 1:size(Ts,1)
        sum_error = sum_error + (ypred(m) - yobs(m))^2;
    end

    RMSE = sqrt(sum_error / size(Ts,1));
end
