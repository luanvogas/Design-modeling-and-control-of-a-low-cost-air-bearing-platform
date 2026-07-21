function [W] = angular_velocity_determination(w_bar,T,N)

    % Savitzky Golay Formulation 

    Z = [];
    for n = -N:N
        Z = [Z ; 1  n*T (n*T)^2];
    end
    
    W = ((Z' * Z) \ Z') * w_bar;
    
end

