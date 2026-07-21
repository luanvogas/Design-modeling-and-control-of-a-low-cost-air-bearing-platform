function [Gm_iden,y] = model_identification_3_poles(average_time, ...
                                                  average_ang_speed, ...
                                                  plot_enable)

    b = -1:0.5:1;
    c = -1:0.5:1;
    aux1 = -1:0.5:-0.1;
    aux2 = 0.1:0.5:1;
    d = [aux1 aux2];
    Ts = average_time;   
    yobs = average_ang_speed;
    
    min_RMSE = 1000;
    
    for j = 1:length(b)
        for k = 1:length(c)
            for l = 1:length(d)
            
                Gm = tf(1,[b(j) c(k) d(l) 1]);
                
                for m = 2:length(Ts)
                    sim = step(Gm,[0 Ts(m)]);
                    ypred(1) = sim(1);
                    ypred(m) = sim(end);
                end
        
                sum_error = 0;
        
                for m = 1:size(Ts,1)
                    sum_error = sum_error + (ypred(m) - yobs(m))^2;
                end
        
                RMSE = sqrt(sum_error / size(Ts,1));
        
                if(RMSE <= min_RMSE)
                    min_RMSE = RMSE; 
                    best_b = b(j);
                    best_c = c(k);
                    best_d = d(l);
                    best_Gm = Gm;
                end 
            end
        end
    end
    
    x0 = [best_b best_c best_d];
    
    [x,fval] = fminsearch(@find_reaction_wheel_model_3_poles,x0);
    
    b_iden = x(1);
    c_iden = x(2);
    d_iden = x(3);
    
    Gm_iden = tf(1,[b_iden c_iden d_iden 1]);
                
    for m = 2:length(average_time)
        sim = step(Gm_iden,[0 average_time(m)]);
        y(1) = sim(1);
        y(m) = sim(end);
    end
    
    if(plot_enable)
        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(average_time,average_ang_speed,'LineWidth',lw)
        hold on
        plot(average_time,y,'LineWidth',lw)
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Normalized Speed','Interpreter','Latex')
        legend('Experimental data','Continuous-time model','Interpreter','Latex','Location','Best')
        xlim([0 10])
    end
end
