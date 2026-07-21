function [] = DLMI_code_validation(validation)

    if(validation)

        % Sistem Matrices - Geromel (2019)
        
        A = [0 1 ; -1 0];
        B = [0 ; 1];
        Ec = B;
        Cd = [1 ; 0]';
        Cc = [1 0 ; 0 0];
        d = 0;
        Dc = [0 ; d];
        Ed = d;
        
        % Controller design
        
        h = 1;
        l = 9;
        ite = 1000;
        theta = 100;
        
        [Hinf,A_hat,B_hat,C_hat,D_hat,calc_runtime,VAR,NLMIs,feasibility] = ...
        H_inf_output_feedback_controller_adapted(A,B,Ec,Cd,Cc,Dc,h,l,theta,ite);

        save('Matlab_Data/DLMI_code_validation')

    else

        load('Matlab_Data/DLMI_code_validation')

    end

    [num,den] = ss2tf(A_hat,B_hat,C_hat,D_hat,h);

    Gc = tf(num,den,h)
end



