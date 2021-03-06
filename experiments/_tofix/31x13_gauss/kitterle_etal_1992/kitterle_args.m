function [args,freqs] = kitterle_args(varargin)
%
%  Final shared settings for 2YP runs
  addpath(genpath('../../../code/'));

  freqs = [0.05 0.15]; % are we sure about this?

  args = de_ArgsInit ( ... %Network structure
         {   'runs',    40,         'ac.randState', 600, ...
             'distn',   {'normre'}, 'mu',           0,    'sigma',       [ 3.0 6.0 ], ...
             'nHidden', 90*4,        'hpl',         4,    'nConns',      8, ...
             ...% Input
             'ac.tol',    0/403, ... %tolerance for disconnected pixels
             ... % Training: ac
             'ac.XferFn',   6,            'ac.useBias',  1, ...
             'ac.AvgError', 5E-3,        'ac.MaxIterations', 150, ...
             'ac.TrainMode','resilient',  'ac.Pow', 3, ... %gradient power (usually 1)
             'ac.EtaInit',  1E-4,         'ac.Acc', 5E-7, 'ac.Dec', 0.25, ... %tanh#2, bias=1 resilient
             'ac.lambda',   0.01,         ...% regularization
              ...
             'p.XferFn', 4,               'p.useBias', 1, ...
                                          'p.nHidden', 10, ...
             'p.AvgError',  0,            'p.MaxIterations', 1000, ...
             'p.TrainMode','batch',       'p.Pow',  1, ...
             'p.EtaInit',   1E-2,         'p.Acc',  1.01,  'p.Dec',  1.15, ... %sig,bias=0
             'p.lambda',   0.001 ...
             ... %rejections
             'ac.rej.props', {'err'},   'p.rej.props', {'err'}, ...
             'ac.rej.type',  {'max'},   'p.rej.type',  {'sample_std-normd'}, ...
             'ac.rej.width', [nan],     'p.rej.width', [3] ...
             ... %output
             'out.data', {'info','mat'}, ...
             'out.plots', {'png'},  ...
             'plots', {'ffts'}, ...
             'stats', {'ffts'}, ...
         }, varargin{:} ); 

