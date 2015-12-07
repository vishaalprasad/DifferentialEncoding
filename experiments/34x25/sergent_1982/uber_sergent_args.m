function [args,opts] = uber_sergent_args(varargin)
%

  % Get shared args
  script_dir = fileparts(which(mfilename));
  addpath(fullfile(script_dir, '..'));

  stats = {};
  plots = {'ls-bars', stats{:}};

  [args,opts] = uber_args( ...
    'runs', 10, ...
    'sigma', [2 4 6 9 12 15 20], ...
    'stats', stats, 'plots', plots, ...
    ...
    'p.zscore', 0.10, ...  % input
    'p.XferFn', [6, 3], ...
    'p.EtaInit', 2.11E-2, ...
    'p.Acc', 5E-6, 'p.Dec', 0.025, ...
    'p.nHidden', 20, ...
    'p.dropout', 0.5, ...
    'p.noise_input', 0, ...
    'p.wlim', 0.5*[-1 1], ...
    'p.MaxIterations', 50, ...
    'p.lambda', 0.01, ...
    'p.AvgError', 0, ...
    'p.rej.width', [3], 'p.rej.type', {'sample_std'}, ...
    varargin{:} ...
);
