% <strong>INSA DYNAMICAL SYSTEMS SUITE</strong>
% Main interface for PRBS generation
% Author: C. Poussot-Vassal [MOR Digital Systems / Onera]
% Date  : April 2021 (creation)
%         March 2025 (modification)
%
% Description
% Computes a PRBS which spectrum power density has a sinc-like behaviour
% which zeros are k-periodic : k/(Ts*M), with M = floor(Tr/Ts/N)
%
% Syntax
%  [u,t,u2,t2] = insa.prbs(N,Tc)
%  [u,t,u2,t2] = insa.prbs(N,Tc,true)
% 
% Input arguments
%  - N  : number of PRBS cell generating a 2^N-1 sequence (integer)
%  - Tc : clock constant sampling time (positive real)
% 
% Optional arguments
%  - Plot : plot the signal and caracteristics (boolean, default true)
% 
% Output arguments
%  - u  : PRBS signal {-1,1}
%  - t  : PRBS time signal
%  - u2 : PRBS over-sampled signal {-1,1}
%  - t2 : PRBS over-sampled time signal
% 
% See also for the Polynomial feedback sequence and explanations on PRBS
% and white noise generation:
% https://www.digikey.fr/fr/articles/techzone/2018/mar/use-readily-available-components-generate-binary-sequences-white-noise
% 

function [u,t,u2,t2] = prbs(N,Tc,Plot)

% Plot
if nargin < 3
    Plot = [];
end
if isempty(Plot)
    Plot = false;
end

% Generation of simulation time
Tf = (2^N-1)*Tc;
t  = 0:Tc:Tf-Tc;
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
si = randi(2,1,N)-1;
% s0 = 0;
% while norm(s0) == 0
%     s0 = randi(2,N,1)-1;
%     si = s0.';
% end
% Iteration using feedback polynomial (periodicity 2^(N-1))
u  = zeros(1,n);
for ii = 1:n
    sN = xor(si(F(1)),si(F(2)));
    for jj = 3:length(F)
        sN = xor(sN,si(F(jj)));
    end
    si       = [sN si(1:N-1)];
    u(ii)    = si(N);
    % for jj = 1:M
    %     u(ii) = sout;
    %     ii    = ii + 1;
    % end
end
% {-1,+1}
u = u(1:n)*2-1;

% Discrete FFT
Fc  = 1/Tc;
L   = numel(u);
FTu = fft(u)/L;
f   = linspace(0,1,L)*Fc;
% Continuous up-sample & FFT
ups     = 100;
Tc2     = Tc/ups;
Fc2     = 1/Tc2;
h       = ones(ups,1);
t2      = 0:Tc2:(t(end)+(ups-1)*Tc2);
u2      = upsample(u,ups);
u2      = filter(h,1,u2);
L       = numel(u2);
FTu2    = fft(u2)/L;
f2      = linspace(0,1,L)*Fc2;

% Zero computation of the rect => sinc function for whitening filter
if Plot
    figure, 
    col = colororder;
    subplot(221); hold on, grid on
    plot(t/Tc,u,'o','LineWidth',3),
    plot(t2/Tc,u2,'-','LineWidth',3), axis tight
    xlabel('$t/T_c$','Interpreter','latex'), ylabel('$\mathbf{u}(t)$','Interpreter','latex')
    legend({'Discrete-time','Continuous-time'},'Location','East')
    %
    subplot(222); hold on; grid on, axis tight
    stem(f/Fc,abs(FTu),'LineWidth',3,'Color',col(1,:)), 
    xlabel('$f/F_c$','Interpreter','latex'), ylabel('$\mathbf{U}(f)$','Interpreter','latex')
    legend({'Discrete-time FFT'},'Location','East')
    %
    subplot(223); hold on; grid on, axis tight
    stem(f/Fc,abs(FTu.*sin(pi*f/Fc)./(pi*f/Fc)),'LineWidth',3,'Color',col(2,:))
    xlabel('$f/F_c$','Interpreter','latex'), ylabel('$\mathbf{U}(f)$','Interpreter','latex')
    legend({'Discrete-time ZOH FFT'},'Location','NorthEast')
    hh = gca;
    %
    xzer = Fc:Fc:Fc*ups;
    subplot(224); hold on; grid on, axis tight
    %plot(f,abs(FTu.*sin(pi*f)./(pi*f)),'.','LineWidth',3)
    plot(f2,abs(FTu2),'-','LineWidth',3,'Color',col(2,:))
    plot(xzer,xzer*0,'.','LineWidth',3,'Color','k')
    set(gca,'XScale','log','YLim',hh.YLim)
    xlabel('$f/F_c$','Interpreter','latex'), ylabel('$\mathbf{U}(f)$','Interpreter','latex')
    legend({'Continuous-time FFT','Zeros'},'Location','NorthEast')
end
