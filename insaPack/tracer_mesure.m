
load('save_STEP.mat')

figure(1)
subplot(2,1,1);
plot(data_signal.simstep) % signal d'entree

subplot(2,1,2);
plot(data_signal.simout) % signal de sortie

step_input = data_signal.simstep.Data;
step_output = data_signal.simout.Data;

step_input = step_input(1:floor(2/3*length(step_input)));
step_output = step_output(1:floor(2/3*length(step_output)));

figure(2)
plot(t2,u2);

%%

load('save_PRBS.mat')

figure(3)
subplot(2,1,1);
plot(data_signal.simstep) % signal d'entree

subplot(2,1,2);
plot(data_signal.simout) % signal de sortie

prbs_input = data_signal.simstep.Data;
prbs_output = data_signal.simout.Data;

prbs_input = prbs_input(1:floor(2/3*length(prbs_input)));
prbs_output = prbs_output(1:floor(2/3*length(prbs_output)));

%%

load('save_CHIRP.mat')

figure(4)
subplot(2,1,1);
plot(data_signal.simstep) % signal d'entree

subplot(2,1,2);
plot(data_signal.simout) % signal de sortie

chirp_input = data_signal.simstep.Data;
chirp_output = data_signal.simout.Data;

chirp_input = chirp_input(1:floor(2/3*length(chirp_input)));
chirp_output = chirp_output(1:floor(2/3*length(chirp_output)));
