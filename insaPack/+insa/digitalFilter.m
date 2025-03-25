% <strong>INSA DYNAMICAL SYSTEMS SUITE</strong>
% Interface for Savitzky-Golay digital filtering for frequency reponse data 
% Author: C. Poussot-Vassal [MOR Digital Systems / Onera]
% Date  : April 2021 (creation)
%
% Description
% A Savitzky-Golay filter is a digital filter that can be applied to a set 
% of digital data points for the purpose of smoothing the data, that is, to 
% increase the signal-to-noise ratio without greatly distorting the signal.
% This is achieved, in a process known as convolution, by fitting 
% successive sub-sets of adjacent data points with a low-degree polynomial 
% by the method of linear least squares. When the data points are equally 
% spaced, an analytical solution to the least-squares equations can be 
% found, in the form of a single set of "convolution coefficients" that can
% be applied to all data sub-sets, to give estimates of the smoothed 
% signal, (or derivatives of the smoothed signal) at the central point of 
% each sub-set.
%
% Syntax
%  Hf = insa.digitalFilter(H,nl)
%  Hf = insa.digitalFilter(H,nl,nr)
%  Hf = insa.digitalFilter(H,nl,nr,d})
% 
% Input arguments
%  - H  : frequency response (e.g. from freqresp) data (complex ny x nu x nw) 
%  - nl : forward step to be smoothed (integer)
% 
% Optional arguments
%  - nr : backward step to be smoothed (integer)
%  - d  : order of the polynomia fitting the data [-nl nr] (d = min(nl,nr))
% 
% Output arguments
%  - Hf : smoothed frequency response (complex ny x nu x nw) 
% 

function Hf = digitalFilter(H,nl,nr,d)
    
    % Input dat treatment
    if nargin < 2
        error('Not enough input arguments')
    end
    if nargin < 3
        nr = nl;
    end
    if nargin < 4
        d = min(nl,nr);
    end
    if d > min(nl,nr)
        d = min(nl,nr);
    end
    
    [ny,nu,N] = size(H);
    % Case, H is a transfer function
    if N > 1
        for in = 1:nu
            for out = 1:ny
                f    = squeeze(H(out,in,1:N));
                gnew = mor_digitalFilter_vector(f,nl,nr,d,N);
                % 
                Hf(out,in,1:N) = gnew;
                %clear gnew g yR yL
            end 
        end
	% Case, H is a single vector
    else
        f    = squeeze(H(:));
        N    = length(f);
        gnew = mor_digitalFilter_vector(f,nl,nr,d,N);
        % 
        Hf = gnew;
    end
end

function gnew = mor_digitalFilter_vector(f,nl,nr,d,N)
    % All data
    g = subFunFilterSG(f,nl,nr,d);
    % Left data
    ii = 1;
    while ii <= nl
        aa            = subFunFilterSG(f,nl-ii,nr,d);
        yL(nl-ii+1,1) = aa(nl-ii+1);
        ii            = ii + 1;
    end
    % Right data
    ii = 1;
    while ii <= nr
        aa            = subFunFilterSG(f,nl,nr-ii,d);
        yR(N-nr+ii,1) = aa(N-nr+ii);
        ii            = ii + 1;
    end
    gnew = [yL; g(nl+1:N-nr); yR(N-nr+1:N)];
end

function g = subFunFilterSG(f,nl,nr,M)

    A = ones(nl+nr+1,M+1);
    for j = M:-1:1
        A(:,j) = [-nl:nr]'.*A(:,j+1);
    end
    [Q,R] = qr(A);
    c     = Q(:,M+1) / R(M+1,M+1);

    n = length(f);
    g = filter(c(nl+nr+1:-1:1),1,f);

    g(nl+1:n-nr) = g(nl+nr+1:n);
end
