function [max_force] = maximum_admissible_force(steady_state_duty,steady_state_force)

    for i = 1:length(steady_state_duty)

        max_duty = find(steady_state_duty{i} == 50);

        mean_max_force(i) = mean(steady_state_force{i}(max_duty));

    end

        max_force = min(mean_max_force);
end