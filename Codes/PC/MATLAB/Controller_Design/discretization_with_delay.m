function [A,B,C,D] = discretization_with_delay(G,td,T)

    [Ac,Bc,Cc,Dc] = tf2ss(G.num{1},G.den{1});
    
    Ad = expm(Ac*T);
    
    sysc = ss(Ac,Bc,Cc,Dc);
    
    Bd1 = expm(Ac*(T-td)) * c2d(sysc,td,'zoh').B;
    
    Bd2 = c2d(sysc,T-td,'zoh').B;
    
    A = [Ad Bd1; zeros(1,size(Ad,2)) 0];
     
    B = [Bd2 ; 1];
    
    C = [Cc 0];
    
    D = Dc;

end