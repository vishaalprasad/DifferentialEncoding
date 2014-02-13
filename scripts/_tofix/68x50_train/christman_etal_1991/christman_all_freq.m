% Christman (1991), identifying low frequency stimuli
clear all variables; clear all globals;
[args,opts] = christman_args();

[mSets, models, stats] = de_Simulator('christman_etal_1991', 'all_freq', 'high-recog', {opts{:}}, args{:});
[mSets, models, stats] = de_Simulator('christman_etal_1991', 'all_freq', 'low-recog',  {opts{:}}, args{:});
