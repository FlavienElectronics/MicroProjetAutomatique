% <strong>INSA DYNAMICAL SYSTEMS SUITE</strong>
% Main interface for PRBS generation
% Author: C. Poussot-Vassal [MOR Digital Systems / Onera]
% Date  : April 2021 (creation)
%
% Description
% Computes a PRBS which spectrum power density has a sinc-like behaviour
% which zeros are k-periodic : k/(Ts*M), with M = floor(Tr/Ts/N)
%
% Syntax
%  u_prbs = insa.prbs(Ts,N)
%  [u_prbs,t] = insa.prbs(Ts,N)
%  [u_prbs,t] = insa.prbs(Ts,N,Tr,P)
% 
% Input arguments
%  - Ts : constant sampling time (positive real)
%  - N  : number of PRBS cell generating a 2^N-1 sequence (integer)
% 
% Optional arguments
%  - Tr   : estimated system response time (positive real, default = N*Ts*10)
%  - P    : number of repetition of the sequence (integer, default 1)
%  - Plot : plot the signal and caracteristics (boolean, default true)
% 
% Output arguments
%  - u_prbs : PRBS signal {0,1}
%  - t      : PRBS time signal
% 
% See also for the Polynomial feedback sequence and explanations on PRBS
% and white noise generation:
% https://www.digikey.fr/fr/articles/techzone/2018/mar/use-readily-available-components-generate-binary-sequences-white-noise
% 

function [u,t] = prbs(Ts,N,Tr,P,Plot)

% Computation of the maximal step duration (N*ts*Tr)
if nargin < 3
    Tr = [];
end
if isempty(Tr)
    Tr = 10*Ts*N;
end
% M = floor(Tr/Ts/N);
% if M == 0
%     M = 1;
% end
M = 1;
% Number of PRBS sequence repetitions
if nargin < 4
    P = [];
end
if isempty(P)
    P = 1;
end
% Plot
if nargin < 5
    Plot = 0;
end
if isempty(Plot)
    Plot = 0;
end

% Generation of simulation time
Tf = P*(2^N-1)*Ts*M;
t  = 0:Ts:Tf-1;
n  = length(t);

% Generate PRBS length and feedback polynomial function
switch N
    case 2
        F = [2 1]; 
    case 3
        F = [3 2]; 
    case 4
        F = [4 3];
    case 5
        F = [5 3]; 
    case 6
        F = [6 5]; 
    case 7
        F = [7 6]; 
    case 8
        F = [8 6 5 4]; 
    case 9
        F = [9 5];
    case 10
        F = [10 7]; 
    case 11
        F = [11 9];
    case 12
        F = [12 6 4 1];
    case 13
        F = [13 4 3 1];
    case 14
        F = [14 5 3 1]; 
    case 15
        F = [15 14]; 
    case 16
        F = [16 15 13 4]; 
    case 17
        F = [17 14]; 
    case 18
        F = [18 11]; 
    case 19
        F = [19 6 2 1];
    case 20
        F = [20, 17]; 
    case 21
        F = [21, 19];
    case 22
        F = [22, 21];
    case 23
        F = [23, 18];
    case 24
        F = [24, 23, 22, 17];
    case 25
        F = [25, 22];
    case 26
        F = [26, 6, 2, 1];
    case 27
        F = [27, 5, 2, 1];
    case 28
        F = [28, 25];
    case 29
        F = [29, 27];
    case 30
        F = [30, 6, 4, 1];
    case 31
        F = [31, 28];
    case 32
        F = [32, 22, 2, 1];
end

% Initial sequence
s0 = 0;
while norm(s0) == 0
    s0 = randi(2,N,1)-1;
    si = s0';
end
% Iteration using feedback polynomial (periodicity 2^(N-1))
ii = 1;
u  = zeros(n,1);
while ii <= n
    sN = xor(si(F(1)),si(F(2)));
    for jj = 3:length(F)
        sN = xor(sN,si(F(jj)));
    end
    % Case length(F) = 3
    % sN       = xor(xor(si(F(1)),si(F(2))),si(F(3)));
    si       = [sN si(1:N-1)];
    sout     = si(N);
    %[ii-1 si sout]
    for jj = 1:M
        u(ii) = sout;
        ii    = ii + 1;
    end
end
u = u(1:n)*2-1;

% Zero computation of the rect => sinc function for whitening filter
% Function being : 
%         u(f) = Ts/Tr*abs(sin(pi*F2*Ts*M)./(pi*F2)) 
% which zeros are k-periodic : 
%         k / (Ts*M)
% ts = 0:1/100:Tf-1/100;
% us = upsample(u,100);
% size(ts)
% size(us)

if Plot
    Fs  = 1/Ts;
    Fn  = Fs/2;
    L   = numel(u);
    FTu = fft(u);%/L;
    F2  = linspace(0,1,fix(L/2)+1)*Fn;
    %F2  = linspace(0,1,L)*Fn;
    Iv  = 1:numel(F2);
    FTu = FTu(Iv);

    figure, 
    subplot(211); hold on, grid on
    plot(t,u,'o','LineWidth',3), axis tight
    stairs(t,u,'LineWidth',3), axis tight
    % plot(ts,us,'--','LineWidth',3), axis tight
    legend({'Discrete-time','Continuous-time'},'Location','best')
    xlabel('t [s]'), ylabel('u(t)')
    subplot(212); hold on; grid on
    stem(F2,abs(FTu),'LineWidth',3), 
    %stem(abs(FTu),'LineWidth',3), 
    %plot(F2,Ts/Tr*abs(sin(pi*F2*Ts*M)./(pi*F2)),'LineWidth',3), axis tight, 
    %plot(F2,abs(sin(pi*F2*Ts*M)./(pi*F2)).^2,'LineWidth',3), axis tight, 
    %set(gca,'YScale','log')
    % if Ts==1/Tr
    %     legend({'Discrete-time'},'Location','best')
    % else
    %     legend({'Continuous-time'},'Location','best')
    % end
    xlabel('f [Hz]'), ylabel('U(f)')
end
