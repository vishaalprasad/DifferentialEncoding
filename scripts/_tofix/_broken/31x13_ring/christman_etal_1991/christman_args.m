function [args,freqs] = christman_args(varargin)
%
%  Final shared settings for 2YP runs
  addpath(genpath('../../code'));

  freqs = [0.06 0.08 0.25 0.45 0.50]%0.06*1.45.^[0:4];
  %0.06*1.45.^[0:4];
  %0.10*1.25.^[0:4];
  %[0.02 0.04 0.08 0.16 0.32];
  %0.75*2*pi*[0.5 1 2 4 8];
  %1.88 2.54 3.28 4.18 5.05];
  
%   0.1261    0.1829    0.2652 @ 0.01 showed HSF adv, LSF inter
  
% 0.0400    0.0600    0.0861 showed lsf adv, hsf inter


  
  % Christman paper:
  %   ntrials: 128 trials/condition * 8 subjects = 1024
  %   model:   1024 trials / 16 trials/model = 64 model instances

  args  = de_ArgsInit({ ... %network structure
              'runs', 14, 'ac.randState', 2, 'p.randState', 2, ...
              'distn', {'norm'}, ...%{'gamma'}, ... %{'gammae'}, ...
              'mu',    0, ...%[2.25  2], ...     %[1.5    1.75], ...
             ...% 'sigma', [ 1.5  3.0  6.0  11.0  18.0 25.0 ], ...%[5   2.5], ...   %[ 20    10 ], ...
              'sigma', [ 3.0 6.0 ], ...%[5   2.5], ...   %[ 20    10 ], ...
              'nHidden', 180, 'hpl', 2, 'nConns', 15, ...
              ... %training
              'errorType', 2, ...
              'ac.AvgError', 0.005, 'ac.MaxIterations', 258, 'ac.errorType', 2, ...
              'p.AvgError',  0,    'p.MaxIterations', 550, 'p.errorType',  2, ...
              'ac.XferFn', 3, 'p.XferFn',   4, ...
              'ac.useBias', 0, 'p.useBias', 1, ...
                               'p.nHidden', 5, ...
             'ac.EtaInit', 0.015,  'ac.Acc', 1.01, 'ac.Dec', 1.25, ...  %sigmoid, bias=0
             'p.EtaInit',  0.005,  'p.Acc',  1.01,  'p.Dec', 1.25 ...
              'ac.lambda', 0.0, 'p.lambda', 0.0, ...% regularization
             ...%rejections
             'ac.rej.props', {'err'},   'p.rej.props', {'err'}, ...
             'ac.rej.type',  {'max'},   'p.rej.type',  {'sample_std-normd'}, ...
             'ac.rej.width', [nan],     'p.rej.width', [3] ...
              ... %output
              'out.data', {'info','mat'}, ...
              'out.plots', {'png'},  ...
              'plots', {}, ...
              'stats', {}, ... 

         }, varargin{:} ); 
