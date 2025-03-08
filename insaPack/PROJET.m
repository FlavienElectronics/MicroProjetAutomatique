% SCRIPT PRINCIPAL

clear all;

Te = 0.025;

    %PRBS

N = 6;      % Nombre de PRBS
Tc = 0.2;     % Horloge constante d'échantillonnage
% Tc^N - 1
Plot = false;
[u1,t1,u2,t2] = insa.prbs(N,Tc,Plot);
%u1 = (u1 + 1)*(5/2);
u2 = (u2 + 1)*(5/2);

simin = transpose([t2;u2]);

data_signal = sim('PROJET_IO.slx'); % lancement simulink

save('save_PRBS.mat');

[~, u2_size] = size(t2)
u2 = ones(1,u2_size)*0;
simin = transpose([t2;u2]);
data_signal = sim('PROJET_IO.slx');

    % STEP

u2 = ones(1,u2_size)*5;
u2(1:round(0.1 * u2_size)) = 0;
u2(end - round(0.2 * u2_size) : end) = 0;

simin = transpose([t2;u2]);

data_signal = sim('PROJET_IO.slx'); % lancement simulink

save('save_STEP.mat');

    % 0

figure(1)
subplot(2,1,1);
plot(data_signal.simstep)
subplot(2,1,2);
plot(data_signal.simout)

figure(2)
plot(t2,u2);
