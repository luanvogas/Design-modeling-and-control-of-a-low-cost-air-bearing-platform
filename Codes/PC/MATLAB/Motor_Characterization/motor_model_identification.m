function [tau_iden,ta_iden,step_sim] = motor_model_identification(time,mean_dynamic_motors,plot_enable)

    tau = 0:0.01:1;
    ta = 0:0.01:0.1;
    
    s = tf('s');
    
    Ts = time;
    
    yobs = mean_dynamic_motors;
    
    min_RMSE = 1000;
    
    for i = 1:size(tau,2)
        for k = 1:size(ta,2)
    
            Gm = tf(1,[tau(i) 1]) * exp(-s*ta(k));
            
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
    
            if(RMSE <= min_RMSE)
                min_RMSE = RMSE;
                best_ta = ta(k);
                best_tau = tau(i);
                best_Gm = Gm;
            end   
        end
    end
        
    x0 = [best_tau best_ta];
    
    [x,fval] = fminsearch(@find_motor_model_with_delay,x0)
    
    tau_iden = x(1)
    ta_iden = x(2)
    
    Gm_iden = tf(1,[tau_iden 1]) * exp(-s*ta_iden);
                
    for l = 2:size(Ts,1)
        sim = step(Gm_iden,[0 Ts(l)]);
        step_sim(1) = sim(1);
        step_sim(l) = sim(end);
    end

    if(plot_enable)
        figure
        lw = 1.5;
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(time,mean_dynamic_motors,'LineWidth',lw)
        hold on
        plot(time,step_sim,'LineWidth',lw)
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Normalized Motor Thrust','Interpreter','Latex')
        legend('Experimental data','Fitted model','Interpreter','Latex','Location','Best')
        xlim([0 1])
        saveas(gcf,'Figures/motor_model_identification','epsc')
    end
    
end