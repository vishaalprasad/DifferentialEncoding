function [cargs, opts] = uber_args(varargin)

  [cargs, opts] = common_args( ...
    'ac.zscore', 0.20, ...
    'ac.TrainMode','resilient', ...
    'ac.AvgError', 2E-3, ...
    'ac.EtaInit', 5E-3, ...
    'ac.Acc', 1E-6, ...
    'ac.Dec', 0.25, ... %5E-7 tanh#2, bias=1 resilient
    'ac.MaxIterations', 50, ...
    'ac.lambda', 0.01, ...
    'ac.noise_input', 0.5, ...
    'ac.wlim', 0.25 * [-1 1], ...
    'ac.rej.width', [3], 'ac.rej.type', {'sample_std'}, ...
    ...
    'p.TrainMode', 'resilient', ...
    'p.EtaInit', 1E-3, ...
    'p.Acc', 1E-6, ...
    'p.Dec', 0.025, ... % even better than 0
    'p.dropout', 0.5, ...
    'p.wlim', 0.5*[-1 1], ...
    'p.lambda', 0.01, ...
    'p.noise_input', 0.00, ...
    'p.AvgError', 0, ...
    'p.rej.width', [3], 'p.rej.type', {'sample_std'}, ...
    ...
    varargin{:} ...
  );


opts = {opts{:}};
