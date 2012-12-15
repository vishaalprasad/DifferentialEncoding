function [args] = lsb_args(varargin)
%
%  Final shared settings for left-side-bias runs
  addpath(genpath('../../code'));

  args    = de_ArgsInit ( ...
         {  'runs', 40, 'ac.randState', 2, 'p.randState', 2, ...
            ...
            'distn', {'norme'}, ...
            'mu', 0, ...
           ...% 'sigma', [ 3.0 18.0 ], ...%[5   2.5], ...   %[ 20    10 ], ...
            'sigma', [ 1.5  3.0  6.0  11.0  18.0 25.0 ], ...%[5   2.5], ...   %[ 20    10 ], ...
            'nHidden', 270, 'hpl', 3, 'nConns', 15, ...
            ...
            'errorType', 2, ...
            'ac.errorType', 2, ...
             ...
            'ac.XferFn',   3,  'ac.useBias',  0,     ...
            'ac.AvgError', 0.01,'ac.MaxIterations', 250,  ...
            'ac.EtaInit', 0.01,   'ac.Acc', 1.01, 'ac.Dec', 1.25, ... %sig,bias=0
            ...
            'p.errorType', 2, ...
            'p.XferFn',    4,       'p.useBias', 1, ...
                                    'p.nHidden', 50, ...
            'p.TrainMode', 'batch', 'p.Pow',     1, ...
            'p.AvgError',  0,       'p.MaxIterations', 5000, ...
            'p.EtaInit',   1E-3,    'p.Acc', 1.01,  'p.Dec', 1.25 ... %tanh#2,bias=1
            'p.lambda', 0, ...
            ...
             'out.plots', {'png'},  ...
             'plots', {}, 'stats', {}, ...
             ...
             'ac.rej.props', {'err'},   'p.rej.props', {'err'}, ...
             'ac.rej.type',  {'max'},   'p.rej.type',  {'sample_std-normd'}, ...
             'ac.rej.width', [nan],     'p.rej.width', [3] ...

          }, varargin{:} ); 
