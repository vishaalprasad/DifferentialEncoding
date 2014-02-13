% Model run with targets and distracter sets swapped

[args,freqs] = uber_args('runs', 50, ...
                         'p.XferFn', 6,               'p.useBias', 1, ...
                                                      'p.nHidden', 5, ...
                         'p.AvgError',  0,            'p.MaxIterations', 2000, ...
                         'p.TrainMode','batch',       'p.Pow',  1, ...
                         'p.EtaInit',   0.005,         'p.Acc',  1.005,  'p.Dec',  1.15, ... %sig,bias=0
                         ...%'p.EtaInit',   1E-2,         'p.Acc',  0,  'p.Dec',  0.15, ... %sig,bias=0
                         'p.lambda',   0.0 ...
                         );

[mSets, models, stats] = de_Simulator('kitterle_etal_1992', 'sf_mixed', 'recog_freq', {'freqs', freqs}, args{:});
