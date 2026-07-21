function RMSE = find_reaction_wheel_model_2_poles(x)    
  
    c = x(1);
    d = x(2);
    
    load('Matlab_Data\average_dynamic.mat')   
    
    Ts = average_time;   
    yobs = average_ang_speed;

    Gm = tf(1,[c d 1]);
            
    for k = 2:length(Ts)
        sim = step(Gm,[0 Ts(k)]);
        ypred(1) = sim(1);
        ypred(k) = sim(end);
    end

    sum_error = 0;

    for m = 1:length(Ts)
        sum_error = sum_error + (ypred(m) - yobs(m))^2;
    end

    RMSE = sqrt(sum_error / size(Ts,1));
end
