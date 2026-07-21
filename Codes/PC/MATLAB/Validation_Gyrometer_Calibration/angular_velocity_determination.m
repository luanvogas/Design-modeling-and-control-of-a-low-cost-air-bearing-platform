function [v_servo] = angular_velocity_determination(t_servo,...
                                                    angle_servo)

    % Calculating the angular velocity of the servo
    
    N = 3;
    Ts = 0.01; % Sampling time    
    
    cont = 0;
    for j = N+1:length(angle_servo)-N-1
        cont = cont + 1;  
        [W] = W_savitzky_golay(angle_servo(j-N:j+N),Ts,N);
        v_servo(cont) = [0 1 0] * W;    
    end
end