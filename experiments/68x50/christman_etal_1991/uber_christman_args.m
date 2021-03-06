function [args,opts] = uber_christman_args(varargin)
%
%  Final shared settings for left-side-bias runs
  % Get shared args
  script_dir = fileparts(which(mfilename));
  addpath(fullfile(script_dir, '..'));  

  [args,opts] = uber_args( ...
                  'runs',   25, ...
                  'errorType', 1, ...
                  'p.errorType', 2,... % cross-entropy
                  'p.XferFn', [6 6], ...  %sigmoid->sigmoid
                  'p.zscore', 0.25, ...
                  'p.EtaInit', 5E-3, ...
                  'p.TrainMode', 'resilient', 'p.Pow', 1, ...
                  'p.Acc', 3E-7, 'p.Dec', 0.25, ...
                  'p.dropout', 0.0, ...
                  'p.nHidden', 400, ...
                  'p.wlim', 2.0*[-1 1], ...
                  'p.lambda',0.005,...
                  'p.MaxIterations', 500, ...
                  varargin{:} ...
                );

%  cycles = [5 12]; % are we sure about this?
%  opts = {opts{:}, 'cycles', cycles};

