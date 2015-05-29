function [args,opts] = uber_okubo_args(varargin)
%
%  Final shared settings for 2YP runs
%   http://www.willamette.edu/~gorr/classes/cs449/classify.html

  % Get shared args
  addpath('..');
  [args,opts] = uber_args( ... %Network structure
                  'ac.AvgError', 2E-4, ...
                  'errorType', 2,... % cross-entropy
                  'p.errorType', 2,... % cross-entropy
                  'p.XferFn', [6 3], ...  %sigmoid->sigmoid
                  'p.zscore', 0.15, ...
                  'p.TrainMode', 'resilient', 'p.Pow', 1, ...
                  'p.EtaInit', 2E-3, ...
                  'p.Acc', 1E-7, 'p.Dec', 0.25, ...
                  'p.nHidden', 10, ...
                  'p.dropout', 0.5, ...
                  'p.noise_input', 0.0, ...
                  'p.wlim', 0.5*[-1 1], ...
                  'p.MaxIterations', 100, ...
                  'p.lambda', 0.01, ...
                  'p.AvgError', 0, 'p.rej.width', [3], 'p.rej.type', {'sample_std-normd'}, ...
                  varargin{:} ...
                 );
