% SCRIPT PRINCIPAL

clear all;

Te = 0.025;

%%
    %PRBS

Te = 0.025;

N = 6;      % Nombre de PRBS
Tc = 0.2;     % Horloge constante d'échantillonnage
% Tc^N - 1
Plot = false;
[u1,t1,u2,t2] = insa.prbs(N,Tc,Plot);
%u2 = (u2 + 1)*(5/2);
u2 = u2*5;

StopTime = 15;
simin = transpose([t2;u2]);

data_signal = sim('PROJET_IO.slx'); % lancement simulink

save('save_PRBS.mat');  

% empty signal for waiting motor to stop
StopTime = 2;
[~, u2_size] = size(t2)
u2 = ones(1,u2_size)*0;
simin = transpose([t2;u2]);
sim('PROJET_IO.slx');

%%
    % STEP

u2 = ones(1,u2_size)*5;
u2(1:round(0.1 * u2_size)) = 0;
u2(end - round(0.2 * u2_size) : end) = 0;

simin = transpose([t2;u2]);

StopTime = 15;
data_signal = sim('PROJET_IO.slx'); % lancement simulink

save('save_STEP.mat');

%%
    % CHIRP

% Generate exciting signal
Wmax    = 200;
f1      = Wmax/(2*pi);
t2      = 0:1/f1:50;
f0      = 1e-2;
tend    = t2(end);
type    = 'logarithmic' %'linear';% 'logarithmic';
u2      = insa.chirp(t2,f0,tend,f1,type);

u2 = (u2)*5;

u2 = transpose(u2);

StopTime = 35;

simin = transpose([t2;u2]);

data_signal = sim('PROJET_IO.slx'); % lancement simulink

save('save_CHIRP.mat');

%%
% empty signal for waiting motor to stop
StopTime = 2;
[~, u2_size] = size(t2)
u2 = ones(1,u2_size)*0;
simin = transpose([t2;u2]);
sim('PROJET_IO.slx');

