clear all variables; clear all globals;

stats = {'ffts'};%images','ffts', 'distns', 'ipd'};
plts = {'ls-bars', stats{:}};

[args,opts]  = uber_sergent_args('sigma', [4 10], 'parallel', false, 'plots',plts,'stats',stats, 'runs', 25);%, 'ac.AvgError', 0, 'ac.MaxIterations', 500);

% Run sergent task by training on all images
[trn, tst] = de_SimulatorUber('vanhateren/100', 'sergent_1982/de/sergent',         opts, args);
