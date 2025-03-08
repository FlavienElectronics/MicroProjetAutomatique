% <strong>INSA DYNAMICAL SYSTEMS SUITE</strong>
% Main interface for Pencil identification method
% Author: C. Poussot-Vassal [MOR Digital Systems / Onera]
% Date  : April 2021 (creation)
% 
% Description
% From the constantly-sampled time-domain signals input output u and y, 
% the routine constructs a linear dynamical descriptor system Hr which 
% response to u generates an output matching y (SISO).
%
% Syntax
%  [Hr,info] = mdspack.ident.base.pencilExtended(u,y,dt,r)
%  
% Input arguments
%  - u  : time-domain input signal (1 x nt, real vector)
%  - y  : time-domain output signal (1 x nt, real vector)
%  - dt : sampling-time (positive real)
%  - r  : order of the generating system 
% 
% Output arguments
%  - Hr   : DAE linear dynamical model (dss)
% 

function Hr = pencil(u,y,dt,r)

    % 
    u = u(:);
    y = y(:);
    % Hankel matrix
    n = length(y);
    if mod(n,2) == 0
        N = n-1;
    else
        N = n;
    end
    Y = y(1:N);
    U = zeros(N,N);
    for ii = 1:N
        U(ii:N,ii) = u(1:N-ii+1);
    end
    h = U\Y;
    %h = pinv(U)*Y;
    k = floor(N/2);
    H = hankel(h(2:k+1),h(k+1:2*k+1)); % \in k x (k+1)
    % State-space interpolant using the Hankel matrix
    E = H(1:k,1:k);
    A = H(1:k,2:k+1);
    B = H(1:k,1);
    C = H(1,1:k);
    D = h(1);
    % Reduction
    [u1,s1,v1]  = svd([E; A]); 
    [u2,s2,v2]  = svd([E  A]);
    %s1          = diag(s1);
    if isempty(r)
        r = length(s1);
    end
    r           = min(r,k);
    X           = u2(1:k,1:r);
    Y           = v1(1:k,1:r);
    Hr          = dss(X'*A*Y,X'*B,C*Y,D,X'*E*Y,dt);
end