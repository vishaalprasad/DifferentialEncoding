function [args,opts] = uber_slotnick_args(varargin)
%

  % Get shared args
  fparts = fileparts(which(mfilename));
  addpath(fullfile(fparts, '..'));

  stats = {};%'images','ffts', 'distns', 'ipd'};
  plots = {stats{:}};

  [args,opts] = uber_args( ... %Network structure
    'runs', 10, ...
    'stats', stats, 'plots', plots, ...
    ...
    'p.zscore', 0.15, ...
    'p.XferFn', [6 3], ...  %sigmoid->sigmoid
    'p.TrainMode', 'resilient', ...
    'p.EtaInit', 2E-3, ...
    'p.Acc', 1E-7, 'p.Dec', 0.25, ...
    'p.nHidden', 50, ...
    'p.dropout', 0.5, ...
    'p.noise_input', 0.0, ...
    'p.wlim', 0.5*[-1 1], ...
    'p.MaxIterations', 200, ...
    'p.lambda', 0.01, ...
    'p.AvgError', 0, 'p.rej.width', [3], 'p.rej.type', {'sample_std-normd'}, ...
    varargin{:} ...
  );
