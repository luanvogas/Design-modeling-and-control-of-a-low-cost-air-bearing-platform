function [] = static_modeling(steady_state_duty_org,steady_state_force_org,display_result,plot_enable)

    for i = 1:length(steady_state_duty_org)
        [a_f{i},b_f{i},c_f{i},d_f{i},transition{i},best_transition{i},J{i},best_J{i},x_plot{i},y_plot{i}] = motor_best_fit(steady_state_duty_org{i},steady_state_force_org{i});
    end

    for i = 1:length(steady_state_duty_org)

        if(display_result)

            display('----------------------------------------------------------------')
            display('----------------------------------------------------------------')
            
            switch i
                case 1 
                    fprintf('Motor 1 \n\n')
                case 2 
                    fprintf('Motor 2 \n\n')
                case 3 
                    fprintf('Motor 3 \n\n')
                case 4 
                    fprintf('Motor 4 \n\n')
                case 5 
                    fprintf('Motor 5 \n\n')
            end        
        
            fprintf('Transitions | Cost\n') 
            fprintf('------------------------\n') 
            for j = 1: length(transition{i})
                fprintf('    %d      | %.4e \n',transition{i}(j),J{i}(j))
            end
            fprintf('------------------------\n') 
            
            fprintf('Better Transition: %d%% \n', best_transition{i})    
        
            fprintf('Transition Point:  %.4e [N] \n',c_f{i} * best_transition{i} + d_f{i})
        
            fprintf('Lowest Cost: %.4e \n', best_J{i})
        
            fprintf('------------------------\n') 
            
            fprintf('Parabola: F = %.4e d^2 + %.4e d [N] \n',a_f{i},b_f{i})
            
            fprintf('Line: F = %.4e d + %.4e [N] \n',c_f{i},d_f{i})
        
            fprintf('------------------------\n') 
        
            fprintf('Parabola: d = (%.4e - sqrt( %.4e + %.4e F)) / %.4e [%% Duty Cycle] \n',-b_f{i}, b_f{i}^2, 4 * a_f{i}, 2*a_f{i})
            
            fprintf('Line: d = %.4e F + %.4e [%% Duty Cycle] \n',1/c_f{i},-d_f{i}/c_f{i})

        end        
    end
    
    if(display_result)
        display('----------------------------------------------------------------')
        display('----------------------------------------------------------------')
    end  

    % Joint plot 

    if (plot_enable)

        lw = 1.5;
        figure
        set(gcf,'units','centimeters','position',[0,0,15,4*length(steady_state_duty_org)])
        tiledlayout(length(steady_state_duty_org),1) 
            
        for i = 1:length(steady_state_duty_org)
            nexttile 
            p1 = plot(x_plot{i},y_plot{i},'b','LineWidth',lw)
            hold on
            p2 = plot(steady_state_duty_org{i},steady_state_force_org{i},'+r','LineWidth',lw)
            grid on
            ylabel({sprintf('Motor %d ', i),'Thrust (N)'}, ...
                   'Interpreter','latex');
        end        
        xlabel('Duty Cycle (\%)','Interpreter','Latex')
        lgd = legend([p1,p2],{'Fitted curve','Collected data'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        if(max(length(steady_state_duty_org)) == 2)
            saveas(gcf,'Figures/static_modeling_pusher','epsc')
        else
            saveas(gcf,'Figures/static_modeling_tractor','epsc')
        end
       
    end
end