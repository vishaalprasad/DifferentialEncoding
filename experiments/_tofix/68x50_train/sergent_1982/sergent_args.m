function [args,opts] = sergent_args(varargin)
%
%  Final shared settings for 2YP runs

  % Get shared args
  script_dir = fileparts(which(mfilename));
  addpath(fullfile(script_dir, '..'));  

  [cargs,opts] = common_args();
    rmpath(script_dir);  % clean paths for running other experimental scripts.

  args = de_ArgsInit ( cargs{:},  ... %Network structure
             'runs',    2, ...
             'p.debug', [],...
             'p.randState', 2, ...
             'p.XferFn', 4,               'p.useBias', 1, ...
                                          'p.nHidden', 1, ...
             'p.AvgError',  0,            'p.MaxIterations', 250, ...
             'p.TrainMode','batch',       'p.Pow', 1, ...
             'p.EtaInit',   2E-2,         'p.Acc',  1.005,  'p.Dec' , 1.25, ... %tanh,bias=1
             'p.lambda', 1E-4, ...
             'p.wmax', inf, ...
             'p.WeightInitScale', 0.01, ...
             ...
             'plots', {'ls-bars'}, ...%'ls-bars', 'ffts', 'images', 'connectivity'}, ...
             'stats', {'ipd', 'err'}, ...%, 'ffts', 'images'}, ...
             varargin{:} );


