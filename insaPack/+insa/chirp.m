% <strong>INSA DYNAMICAL SYSTEMS SUITE</strong>
% Main interface for chirp signal generation
% Author: C. Poussot-Vassal [MOR Digital Systems / Onera]
% Date  : April 2021 (creation)
%
% Description
% Computes a chirp signal sweeping from f0 to f1.
%
% Syntax
%  u_chirp = insa.chirp(t,f0,t1,f1)
%  u_chirp = insa.chirp(t,f0,t1,f1,type)
% 
% Input arguments
%  - t  : time vector with constant sampling Ts (real, N x 1)
%  - f0 : starting frequency in Hz (real)
%  - t1 : final frequency time (real <= t(end))
%  - f1 : final frequency in Hz (real)
% 
% Optional arguments
%  - type : variation of the chirp linear from f0 -> f1 being 'linear'
%           (default), 'quadratic' or 'logarithmic' 
% 
% Output arguments
%  - u_chirp : chirp signal in [-1,1]
% 

function u = chirp(t,f0,t1,f1,type)

    phi = 0;
    % Set p=1 for linear, 2 for quadratic, 3 for logarithmic
    if nargin < 5 
        type = 'linear';
    end
    switch type
        case 'linear'
            p = 1;
        case 'quadratic'
            p = 2;
        case 'logarithmic'
            p = 3;
        otherwise
            p = 1;
    end
    beta = (f1-f0).*(t1.^(-p));
    Uchi = cos(2*pi * ( beta./(1+p).*(t.^(1+p)) + f0.*t + phi/360));
    u    = Uchi';
    
end