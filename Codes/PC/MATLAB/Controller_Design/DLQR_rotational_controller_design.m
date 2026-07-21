function [K] = DLQR_rotational_controller_design(Gdv, ...
                                                 T, ...
                                                 ts, ...
                                                 max_ang_error, ...
                                                 uproj, ...
                                                 plot_enable, ...
                                                 print_enable)   

    %% Discretization of the velocity mesh
    
    sys_vm= c2d(Gdv,T,'zoh');
    
    conversion  = tf([1 -1],[1 0],T);
    
    sysv = sys_vm*conversion;
    
    %% Discretization of the position mesh
    
    s = tf('s');
    
    Gdp = Gdv/s;
    
    [Ap,Bp,Cp,Dp] = discretization_with_delay(Gdp,ts,T);
    
    [num_pm,den_pm] = ss2tf(Ap,Bp,Cp,Dp);
    
    Gdpi = tf(num_pm,den_pm,T)*conversion;
    
    %% State-space representation
    
    % Duty - Velocity
    
    numv = sysv.num{1};
    denv = sysv.den{1};
    
    b3v = numv(2);
    b2v = numv(3);
    b1v = numv(4);
    b0v = numv(5);
    a3v = denv(2);
    a2v = denv(3);
    a1v = denv(4);
    a0v = denv(5);
    
    % Duty - Position
    
    nump = Gdpi.num{1};
    denp = Gdpi.den{1};
    
    b5p = nump(2);
    b4p = nump(3);
    b3p = nump(4);
    b2p = nump(5);
    b1p = nump(6);
    b0p = nump(7);
    a5p = denp(2);
    a4p = denp(3);
    a3p = denp(4);
    a2p = denp(5);
    a1p = denp(6);
    a0p = denp(7);    
    
    A_aug = [-a5p -a4p -a3p -a2p -a1p -a0p 0 0 0 0 b4p b3p b2p b1p b0p; 
              1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
              0 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
              0 0 1 0 0 0 0 0 0 0 0 0 0 0 0;
              0 0 0 1 0 0 0 0 0 0 0 0 0 0 0;
              0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;
              0 0 0 0 0 0 -a3v -a2v -a1v -a0v b2v b1v b0v 0 0;
              0 0 0 0 0 0 1 0 0 0 0 0 0 0 0;
              0 0 0 0 0 0 0 1 0 0 0 0 0 0 0;
              0 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
              0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
              0 0 0 0 0 0 0 0 0 0 1 0 0 0 0;
              0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
              0 0 0 0 0 0 0 0 0 0 0 0 1 0 0;
              0 0 0 0 0 0 0 0 0 0 0 0 0 1 0];

    B_aug = [b5p ; 0 ; 0 ; 0 ; 0 ; 0 ; b3v ; 0 ; 0 ; 0 ; 1 ; 0 ; 0 ; 0 ; 0 ];
    
    C_aug = eye(size(A_aug,1));
    
    D_aug = zeros(size(A_aug,1),1);    
    
    %% Minimum realization
    
    sys_aug = ss(A_aug,B_aug,C_aug,D_aug);
    
    min_sys = minreal(sys_aug);
    
    A = min_sys.A;
    
    B = min_sys.B;
    
    C = min_sys.C;
    
    D = min_sys.D;

    % Open loop eigenvalues

    if(print_enable)    
        display('Open loop eigenvalues:')
        eig(A)
    end    
    
    %% Conversion between representations
    
    if(rank(C) == size(A,1))
        C_pinv = (C'*C)\C';
    end
    
    %% Controllability
    
    Pc = [B A*B A^2*B A^3*B A^4*B A^5*B A^6*B A^7*B A^8*B A^9*B];
    
    if(print_enable)
        if (rank(Pc) == size(A,1))
            display('The system is controllable!')
        end
    end

    %% Controllable canonical form
    
    Pc_inv = eye(size(A,1))/Pc;
    
    h = Pc_inv(end,:);
    
    T_sim = [h ; h*A ; h*A^2 ; h*A^3 ; h*A^4 ; h*A^5 ; h*A^6 ; h*A^7 ; h*A^8 ; h*A^9];
        
    A_b = T_sim*A/T_sim;
    
    B_b = T_sim*B;

    if(print_enable)
        display('Controllable canonical form:')

        A_b
        B_b
    end
    
    a_line = A_b(end,:);
    a0_b = -a_line(1);
    a1_b = -a_line(2);
    a2_b = -a_line(3);
    a3_b = -a_line(4);
    a4_b = -a_line(5);
    a5_b = -a_line(6);
    a6_b = -a_line(7);
    a7_b = -a_line(8);
    a8_b = -a_line(9);
    a9_b = -a_line(10);
    
    polos_G = roots([1 a9_b a8_b a7_b a6_b a5_b a4_b a3_b a2_b a1_b a0_b]);
    
    %% Controller design
    
    zeros_G = [];
    
    [G_num,G_den] = zp2tf(zeros_G',polos_G,1);
    
    Gz = tf(G_num,G_den,T);
    
    C = G_num(end:-1:2);
    Gz_inv = tf(G_num(end:-1:1),G_den(end:-1:1),T);
    H = Gz_inv*Gz;    

    % Rlocus 

    N = 1000;
    q = logspace(-10,2,N);
    
    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        hold on
        
        for i = 1:N
            pp = pole(feedback(q(i)*H,1));
            plot(pp,'.b')
        end
        xlabel('Real Axis','Interpreter','latex')
        ylabel('Imaginary Axis','Interpreter','latex')
        zgrid
        axis([-1 1 -1 1])
        saveas(gcf,'Figures/DLQR/root_locus_rotation','epsc')
    end   
    
    x0 = [max_ang_error ; max_ang_error ; max_ang_error ; max_ang_error ; max_ang_error ; max_ang_error ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0];

    best_u0 = 0;
        
    for i = 1:N    
        q_proj = q(i);    
        Q = q_proj*(C'*C);
        R = 1;
        
        [K_b,S,e] = dlqr(A_b,B_b,Q,R);
    
        K_min = K_b * T_sim;
    
        K = K_min*C_pinv;
    
        u0 = -K*x0;
    
        if((abs(u0) > best_u0) && (abs(u0) <= uproj))
            best_u0 = abs(u0);
            best_i = i;
        end
    end   
    
    q_proj = q(best_i);
    
    Q = q_proj*(C'*C);
    R = 1;
    
    [K_b,S,e] = dlqr(A_b,B_b,Q,R);    
      
    K_min = K_b * T_sim;
    
    K = K_min*C_pinv;
    
    u0 = -K*x0;

end


