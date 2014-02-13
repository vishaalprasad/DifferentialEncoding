clear all variables; clear all globals;

stats = {'connectivity', 'images','ffts'};
plts = {stats{:}};

[args,opts] = uber_face_args( 'plots',plts,'stats',stats,'runs',25 );

% Run sergent task by training on all images
[trn, tst] = de_SimulatorUber('vanhateren/100', 'young_bion_1981/orig/recog', opts, args);
