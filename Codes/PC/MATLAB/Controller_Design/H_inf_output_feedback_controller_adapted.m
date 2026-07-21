function [Hinf,A_hat,B_hat,C_hat,D_hat,calc_runtime,VAR,NLMIs,feasibility] = ...
H_inf_output_feedback_controller_adapted(A,B,Ec,Cd,Cc,Dc,h,l,theta,ite)

%============================= Initialization =============================

% Verification of the number of function input arguments

if (nargin < 10)
    error('Please, check the number of input arguments!');
end

% Program parameters

nh = 2^l;                     % Divisions in the sampling period
eta = h/nh;                   % Used in the approximation of the derivative
options = [0,ite,0,0,0];      % Options of the mincx function
feasibility = 1;              % Initialization of the feasibility indicator

% Dimension definitions

nx = size(A,1);   % State vector
nu = size(B,2);   % Control
rc = size(Ec,2);  % Coninuous-time exogenous input
ny = size(Cd,1);  % Discrete-time output
nz = size(Cc,1);  % Continuous-time Controlled output
nc = nu + nx;        % Controller state vector

% Hybrid system definition

F = [A B zeros(nx,nc) ; zeros(nu+nc,nx+nu+nc)];
G = [Cc Dc zeros(nz,nc)];
Jc = [Ec ; zeros(nu+nc,rc)];

% Auxiliary matrices

F0 = [A B ; zeros(nu,nx+nu)];
G0 = [Cc Dc];
Ec0 = [Ec ; zeros(nu,rc)];
Cd0 = [Cd zeros(ny,nu)];

I00 = [eye(nx) zeros(nx,nu) ; zeros(nu,nx+nu)];

I0 = [zeros(nx,nu) ; eye(nu)];

%=========================== Problem Resolution ===========================

tic % Initialization of the calculation runtime

setlmis([]); % Reset for the creation of the LMI system

% Variables

for t = 1:nh+1
    X{t} = lmivar(1,[nc 1]);
    Y{t} = lmivar(1,[nc 1]); 
end
square_gamma = lmivar(1,[1 0]);
M = lmivar(2,[nc nc]);
K = lmivar(2,[nc size(Cd,1)]);
L = lmivar(2,[nu nc]);
D = lmivar(2,[ny size(Cd,1)]);

%------------------------------- First DLMI -------------------------------

for t = 1:nh
    
    % First part of the DLMI approximation
    
    lmi = newlmi;
    
    % (1,1) [X(t+1)-X(t)]/eta + F0*'X(t) + X(t)*F0
    
    lmiterm([lmi,1,1,X{t+1}],1/eta,1);
    lmiterm([lmi,1,1,X{t}],-1/eta,1);        
    lmiterm([lmi,1,1,X{t}],1,F0,'s');
    
    % (1,2) G0'
    
    lmiterm([lmi,1,2,0],G0');

    % (1,3) X(t)*Ec0

    lmiterm([lmi,1,3,X{t}],1,Ec0);
    
    % (2,2) -Inz 
    
    lmiterm([lmi,2,2,0],-eye(nz));

    % (2,3) 0

    % (3,3) -gamma^2 * Irc

    lmiterm([lmi,3,3,square_gamma],-1,eye(rc));        
    
    % Second part of the DLMI approximation
    
    lmi = newlmi;
    
    % (1,1) [X(t+1)-X(t)]/eta + F0*'X(t+1) + X(t+1)*F0
    
    lmiterm([lmi,1,1,X{t+1}],1/eta,1);
    lmiterm([lmi,1,1,X{t}],-1/eta,1);        
    lmiterm([lmi,1,1,X{t+1}],1,F0,'s');
    
    % (1,2) G0'
    
    lmiterm([lmi,1,2,0],G0');

    % (1,3) X(t+1)*Ec0

    lmiterm([lmi,1,3,X{t+1}],1,Ec0);
    
    % (2,2) -Inz 
    
    lmiterm([lmi,2,2,0],-eye(nz));

    % (2,3) 0

    % (3,3) -gamma^2 * Irc

    lmiterm([lmi,3,3,square_gamma],-1,eye(rc));
    
end

%------------------------------ Second DLMI ------------------------------

for t = 1:nh
    
    % First part of the DLMI approximation
    
    lmi = newlmi;
    
    % (1,1) -[Y(t+1)-Y(t)]/eta + F0*Y(t) + Y(t)*F0'
    
    lmiterm([lmi,1,1,Y{t+1}],-1/eta,1);
    lmiterm([lmi,1,1,Y{t}],1/eta,1);        
    lmiterm([lmi,1,1,Y{t}],F0,1,'s');
    
    % (1,2) Y(t)*G0'
    
    lmiterm([lmi,1,2,Y{t}],1,G0');

    % (1,3) Ec0

    lmiterm([lmi,1,3,0],Ec0);
    
    % (2,2) -Inz 
    
    lmiterm([lmi,2,2,0],-eye(nz));

    % (2,3) 0

    % (3,3) -gamma^2 * Irc

    lmiterm([lmi,3,3,square_gamma],-1,eye(rc));        
    
    % Second part of the DLMI approximation
    
    lmi = newlmi;
    
    % (1,1) -[Y(t+1)-Y(t)]/eta + F0*Y(t+1) + Y(t+1)*F0'
    
    lmiterm([lmi,1,1,Y{t+1}],-1/eta,1);
    lmiterm([lmi,1,1,Y{t}],1/eta,1);        
    lmiterm([lmi,1,1,Y{t+1}],F0,1,'s');
    
    % (1,2) Y(t+1)*G0'
    
    lmiterm([lmi,1,2,Y{t+1}],1,G0');

    % (1,3) Ec0

    lmiterm([lmi,1,3,0],Ec0);
    
    % (2,2) -Inz 
    
    lmiterm([lmi,2,2,0],-eye(nz));

    % (2,3) 0

    % (3,3) -gamma^2 * Irc

    lmiterm([lmi,3,3,square_gamma],-1,eye(rc));   
    
end

%-------------------------------- First LMI -------------------------------

for t = 1:nh+1    

    lmi = newlmi;

    % (1,1) theta*Inc

    lmiterm([-lmi,1,1,0],theta*eye(nc));

    % (1,2) Inc

    lmiterm([-lmi,1,2,0],eye(nc));

    % (1,3) 0

    % (2,2) X(t)

    lmiterm([-lmi,2,2,X{t}],1,1);

    % (2,3) Inc

    lmiterm([-lmi,2,3,0],eye(nc));

    % (3,3) Y(t)

    lmiterm([-lmi,3,3,Y{t}],1,1);

end

%------------------------------- Second LMI -------------------------------
    
lmi = newlmi;

% (1,1) X(nh+1)

lmiterm([-lmi,1,1,X{nh+1}],1,1);

% (1,2) Inc

lmiterm([-lmi,1,2,0],eye(nc));

% (1,3) I00*X(1) + Cd0'*K'

lmiterm([-lmi,1,3,X{1}],I00,1);
lmiterm([-lmi,1,3,-K],Cd0',1);

% (1,4) I00 + Cd0'*D'*I0'

lmiterm([-lmi,1,4,0],I00);
lmiterm([-lmi,1,4,-D],Cd0',I0');

% (2,2) Y(nh+1)

lmiterm([-lmi,2,2,Y{nh+1}],1,1);

% (2,3) M'

lmiterm([-lmi,2,3,-M],1,1);

% (2,4) Y(nh+1)*I00 + L'I0' 

lmiterm([-lmi,2,4,Y{nh+1}],1,I00);
lmiterm([-lmi,2,4,-L],1,I0');

% (3,3) X(1)

lmiterm([-lmi,3,3,X{1}],1,1);

% (3,4) Inc

lmiterm([-lmi,3,4,0],eye(nc));

% (4,4) Y(1)

lmiterm([-lmi,4,4,Y{1}],1,1);    


%--------------------------------------------------------------------------

% Definition of the description of the LMI system

lmisys = getlmis; 

% Optimization 

nvar=decnbr(lmisys);

c = zeros(nvar,1);  

for i = 1:nvar
    c(i) = defcx(lmisys,i,square_gamma);  
end

[copt,xopt] = mincx(lmisys,c,options);

calc_runtime = toc; % Finalization of the calculation runtime

%================================ Solution ================================

if isempty(copt)    
    feasibility = 0;
    warning('The problem is infeasible!');
    Hinf = []; 
    A_hat = [];
    B_hat = [];
    C_hat = [];
    D_hat = [];
    calc_runtime = [];
    VAR = [];
    NLMIs = [];
else
    square_gamma_sol = dec2mat(lmisys,xopt,square_gamma);
    Hinf = sqrt(square_gamma_sol);
    for t = 1:nh+1
        X_sol{t} = dec2mat(lmisys,xopt,X{t});        
        Y_sol{t} = dec2mat(lmisys,xopt,Y{t});
        Z{t} = Y_sol{t}\eye(size(Y_sol{t}));
    end
    for t = 1:nh
        X_dot{t} = (X_sol{t+1}-X_sol{t})/eta;
    end
    M_sol = dec2mat(lmisys,xopt,M);
    K_sol = dec2mat(lmisys,xopt,K);
    L_sol = dec2mat(lmisys,xopt,L);
    D_sol = dec2mat(lmisys,xopt,D);

    for t = 1:nh
        R{t} = -(X_dot{t} + X_sol{t}*F0+F0'*Z{t} + (1/square_gamma_sol)*X_sol{t}*Ec0*Ec0'*Z{t}+G0'*G0);
    end

    Phi{1} = eye(nc);

    for t = 1:nh
        Phi{t+1} = Phi{t} + eta*((R{t}/(Z{t}-X_sol{t}))*Phi{t}); 
    end

    V0 = eye(nc);

    Vh = Phi{nh+1}*V0;    

    invUht = (eye(nc)-X_sol{nh+1}*Y_sol{nh+1})\Vh;

    Cmat_aux1 = [V0 X_sol{1}*I0 ; zeros(nu,size(V0,2)) eye(nu)];
    Cmat_aux2 = [M_sol-X_sol{1}*I00*Y_sol{nh+1} K_sol ; L_sol D_sol];
    Cmat_aux3 = [invUht zeros(nc,ny) ; -Cd0*Y_sol{nh+1}*invUht eye(ny)];

    Cmat = (Cmat_aux1 \ Cmat_aux2) * Cmat_aux3;     

    A_hat = Cmat(1:nc,1:nc);
    B_hat = Cmat(1:nc,nc+1:end);
    C_hat = Cmat(nc+1:end,1:nc);
    D_hat = Cmat(nc+1:end,nc+1:end);

    VAR = decnbr(lmisys);
    NLMIs = lminbr(lmisys);
end  

%==========================================================================

end