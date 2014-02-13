function [args,c_freqs,k_freqs] = uber_args(varargin)
%
%  Final shared settings for 2YP runs
  addpath(genpath('../../code'));
c_freqs = [0.06 0.08 0.25 0.45 0.50];
k_freqs = [0.05 0.15];

  args  = de_ArgsInit({ ...
              'runs', 68, 'ac.randState', 20,  ...
              'distn', {'normre-center'},  'mu',  [2.0 3.0],   'sigma', [ 1 2 ], ...
              'nHidden', 192*4, 'hpl', 4, 'nConns', 9, ...
             ...
             'ac.tol', 0/850, ...
             ...
             'ac.XferFn', 6, 'ac.useBias', 0, ...
             'ac.AvgError', 1E-6, 'ac.MaxIterations', 150, ...
             'ac.TrainMode','resilient', 'ac.Pow', 9, ...
             'ac.EtaInit',  1E-4,  'ac.Acc', 1E-6, 'ac.Dec', 0.15, ... %tanh#2, bias=1 resilient
             'ac.lambda', [0.025 0.025] ... 
              ...
             'ac.rej.props', {'err'}, ...
             'ac.rej.type',  {'max'}, ...
             'ac.rej.width', [nan],   ...
              ...
              'out.data', {'info','mat'}, ...
              'out.plots', {'png'},  ...
              'plots', {'images','ffts','connectivity'}, ...
              'stats', {'ffts'}, ... 

         }, varargin{:} ); 
                       