function [steady_state_duty,steady_state_force] = steady_state_values(step_time,step_duty,step_force)

    for i = 1:length(step_time)

        steady_state_duty{i} = [];
        steady_state_force{i} = [];

        for j = 1:length(step_time{i})

            final_samples = find(step_time{i}{j} >= 0.5);

            steady_state_duty{i} = [steady_state_duty{i} ; mean(step_duty{i}{j}(final_samples))];
            steady_state_force{i} = [steady_state_force{i} ; mean(step_force{i}{j}(final_samples))];
            
        end
    end
end





