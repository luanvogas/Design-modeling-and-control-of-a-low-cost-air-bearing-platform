function [t,...
          x_disturbance,...
          x_measured_position,...
          y_measured_position,...
          x_control,...
          y_control] = DLMI_disturbance_rejection_simulation()

    % Simulation
    
    DLMI_dist_rej_sim = sim('DLMI_disturbance_rejection_simulink');
    
    t = DLMI_dist_rej_sim.time.Data;
    x_measured_position = DLMI_dist_rej_sim.x_measured_position.Data;
    y_measured_position = DLMI_dist_rej_sim.y_measured_position.Data;
    x_disturbance = DLMI_dist_rej_sim.x_disturbance.Data;
    x_control = DLMI_dist_rej_sim.x_control.Data;
    y_control = DLMI_dist_rej_sim.y_control.Data;    
    
end