function [args,opts] = uber_sergent_args(varargin)
%
%  Final shared settings for 2YP runs
%   http://www.willamette.edu/~gorr/classes/cs449/classify.html

  % Get shared args
  script_dir = fileparts(which(mfilename));
  addpath(fullfile(script_dir, '..'));  

  [args,opts] = uber_args( ...% 'out.pub', true, ... %Network structure
                  'p.zscore', 0.0250, ...
                  'p.XferFn', [6 3], ...  %sigmoid->sigmoid
                  'p.errorType', 2, ...
                  'errorType', 2, ...
                  'p.TrainMode', 'resilient', 'p.Pow', 1, ...
                  'p.EtaInit', 2.1E-2, ...
                  'p.Acc', 5E-6, 'p.Dec', 0.025, ...
                  'p.nHidden', 10, ...
                  'p.dropout', 0.5, ...
                  'p.noise_input', 0.005, ...
                  'p.wlim', 0.15*[-1 1], ...
                  'p.MaxIterations', 100, ...
                  'p.lambda', 0.05, ...%025, ...
                  'p.AvgError', 0, 'p.rej.width', [3], 'p.rej.type', {'sample_std-normd'}, ...
                  varargin{:} ...
                 );
