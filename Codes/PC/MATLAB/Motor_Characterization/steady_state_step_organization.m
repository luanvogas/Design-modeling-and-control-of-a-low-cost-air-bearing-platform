function [steady_state_duty_org,steady_state_force_org] = steady_state_step_organization(steady_state_duty,steady_state_force,plot_enable)

    for i = 1:length(steady_state_duty)
        if (plot_enable)
            figure
        end  
        steady_state_duty_org{i} = [];
        steady_state_force_org{i} = [];
        duty_vector = 5:5:50;
        for j = 1:length(duty_vector)    
            for k = 1:length(steady_state_duty{i})          
                if(steady_state_duty{i}(k) == duty_vector(j))
                    steady_state_duty_org{i} = [steady_state_duty_org{i} ; steady_state_duty{i}(k)];
                    steady_state_force_org{i} = [steady_state_force_org{i} ; steady_state_force{i}(k)];                     

                    if (plot_enable)
                        plot(steady_state_duty{i}(k),steady_state_force{i}(k),'.')
                        hold on
                    end

                end                   
            end            
        end       
        
        if (plot_enable)
            grid on
            xlabel('Duty Cycle (\%)','Interpreter','Latex')
            ylabel('Motor Thrust (N)','Interpreter','Latex')
        end
    end    
end


