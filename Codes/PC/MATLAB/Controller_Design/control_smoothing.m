function [smoothed_time,smoothed_control] = control_smoothing(time,...
                                                              control)

    N = 9;
    Ts = 0.125;  
    
    cont = 0;
    for j = N+1:length(control)-N-1
        cont = cont + 1;  
        [W] = W_savitzky_golay(control(j-N:j+N),Ts,N);
        smoothed_control(cont) = [1 0 0] * W;   
    end
    smoothed_time = time(N+1:end-N-1);
end