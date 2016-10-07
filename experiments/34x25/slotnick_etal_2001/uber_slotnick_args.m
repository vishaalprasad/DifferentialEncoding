function [args,opts] = uber_slotnick_args(varargin)
%

  % Get shared args
  fparts = fileparts(which(mfilename));
  addpath(fullfile(fparts, '..'));

  stats = {};%'images','ffts', 'distns', 'ipd'};
  plots = {stats{:}};

  [args,opts] = uber_args( ... %Network structure
    'runs', 100, ...
    'stats', stats, 'plots', plots, ...
    'nConns', 10, ...
    'hpl', 4, ...
    'nHidden', 850 * 4, ...
    ...
    'p.zscore', 0.20, ...
    'p.XferFn', [6 3], ...  %sigmoid->sigmoid
    'p.TrainMode', 'resilient', ...
    'p.EtaInit', 2E-3, ...
    'p.Acc', 1E-4, ...
    'p.nHidden', 20, ...
    'p.MaxIterations', 100, ...
    varargin{:} ...
  );
