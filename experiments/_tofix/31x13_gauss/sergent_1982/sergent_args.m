function args = depp_2D_args(varargin)
%
%  Final shared settings for 2YP runs
  addpath(genpath('../../../code/'));

  args = de_ArgsInit ( ... %Network structure
         {   'runs',    68,         'ac.randState', 52,    'p.randState', 52, ...
             'distn',   {'norme'}, 'mu', 0, 	   'sigma',       [ 3.0 6.0 ], ...
             'nHidden', 60*4       'hpl',          4,    'nConns',      6, ...
             ...% Input
             'ac.tol',    0/403, ... %tolerance for disconnected pixels
             ... % Training
             'ac.XferFn',   4,            'ac.useBias',  1, ...
             'ac.AvgError', 4E-2,        'ac.MaxIterations', 250, ...
             'ac.TrainMode','batch',     'ac.Pow', 1, ... %gradient power (usually 1)
             'ac.EtaInit',  7E-3,         'ac.Acc', 1.005, 'ac.Dec', 1.25, ... %tanh#2, bias=1 resilient
             'ac.lambda',   0.025,  ...% regularization
             'ac.wmax',     1, ...
             ...
             'p.XferFn', 4,               'p.useBias', 1, ...
                                          'p.nHidden',1, ...
             'p.AvgError',  0,            'p.MaxIterations', 250, ...
             'p.TrainMode','batch',       'p.Pow', 1, ...
             'p.EtaInit',   0.005,         'p.Acc',  1.005,  'p.Dec'  1.25 ... %sig,bias=0
             'p.lambda', 0.025, ...
             ... %rejections
             'ac.rej.props', {'err'},   'p.rej.props', {'err'}, ...
             'ac.rej.type',  {'max'},   'p.rej.type',  {'sample_std-normd'}, ...
             'ac.rej.width', [nan],     'p.rej.width', [3] ...
             ... %output
             'out.data', {'info','mat'}, ...
             'out.plots', {'png'},  ...
             'plots', {'ls-bars','ffts','images','connectivity'}, ...
             'stats', {'ipd','ffts','images'}, ...
         }, varargin{:} );

%             'ac.AvgError', 4E-3,        'ac.MaxIterations', 102, ...
%             'ac.TrainMode','resilient',  'ac.Pow', 3, ... %gradient power (usually 1)
%             'ac.EtaInit',  5E-2,         'ac.Acc', 1E-5, 'ac.Dec', 0.25, ... %tanh#2, bias=1 resilient
%             'ac.lambda',   0.025,  ...% regularization

%             'p.XferFn', 6,               'p.useBias', 1, ...
%                                          'p.nHidden', 5, ...
%             'p.AvgError',  0,            'p.MaxIterations', 250, ...
%             'p.TrainMode','resilient',   'p.Pow', 3, ...
%             'p.EtaInit',   0.001,         'p.Acc',  0.00025,  'p.Dec'  0.25 ... %sig,bias=0
%             'p.lambda', 0.05, ...
