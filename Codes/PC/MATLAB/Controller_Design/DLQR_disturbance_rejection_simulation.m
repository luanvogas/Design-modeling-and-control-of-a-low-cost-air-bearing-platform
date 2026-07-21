function [t,...
          x_disturbance,...
          x_measured_position,...
          y_measured_position,...
          x_control,...
          y_control] = DLQR_disturbance_rejection_simulation()

    % Simulation
    
    DLQR_dist_rej_sim = sim('DLQR_disturbance_rejection_simulink');
    
    t = DLQR_dist_rej_sim.time.Data;
    x_measured_position = DLQR_dist_rej_sim.x_measured_position.Data;
    y_measured_position = DLQR_dist_rej_sim.y_measured_position.Data;
    x_disturbance = DLQR_dist_rej_sim.x_disturbance.Data;
    x_control = DLQR_dist_rej_sim.x_control.Data;
    y_control = DLQR_dist_rej_sim.y_control.Data;    
    
end