clear all variables; clear all globals;

stats = {'freqprefs'};%'ipd', 'ffts', 'distns'};
plts = {'ls-bars', stats{:}};

[args,opts]  = uber_sergent_args('parallel', false, 'plots',plts, 'stats',stats);

% Run sergent task by training on all images
[trn, tst] = de_SimulatorUber('vanhateren/250', 'sergent_1982/de/sergent', opts, args);
