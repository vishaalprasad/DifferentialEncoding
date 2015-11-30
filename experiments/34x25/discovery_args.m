function [cargs, opts] = discovery_args(varargin)
% These args are for exploring the parameter space.

  % Add absolute path to code
  script_dir = fileparts(which(mfilename));
  addpath(fullfile(script_dir, '..'));  

  [cargs, opts] = common_args();
  rmpath(script_dir);  % clean paths for running other experimental scripts.

  args = de_ArgsInit ( cargs{:}, ... %Network structure
             ...
             'p.useBias',  1, ...
             ...
             'p.WeightInitScale', 0.10, ...
             'p.WeightInitType', 'sprandn', ...
             'p.wlim',            [-inf inf],         ...% regularization
             'p.dropout', 0.0, ...
             'p.noise_input',     0,         ...% regularization
             'p.lambda',          0.00,         ...% regularization
             ...
            'p.errorType', 3,... % cross-entropy
            'p.XferFn', [6 3], ...  %sigmoid->sigmoid
            'p.TrainMode', 'resilient', ...
            'p.EtaInit', 5E-2, ...
            'p.Acc', 1E-7, ...
            'p.Dec', 0.25, ...
              ...
             varargin{:} ...
           );
