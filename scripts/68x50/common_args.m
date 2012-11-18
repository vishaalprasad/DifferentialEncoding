function [cargs, opts] = common_args(varargin)

  % Add absolute path to code
  if (exist('de_GetBaseDir')~=2)
    addpath(genpath(fullfile('..','..', 'code')));
    addpath(genpath(fullfile('..','..','..', 'code')));
    addpath(genpath(fullfile(de_GetBaseDir(),'code')));
    rmpath (genpath(fullfile('..','..','..', 'code')));
    rmpath (genpath(fullfile('..','..', 'code')));
  end;

  opts = {'medium'}; %[68 50];

  cargs = {  'parallel', false, 'debug', 1:10, 'ac.debug', 1:10, 'p.debug', 1:10, ...
             'runs', 40, 'ac.randState', 4, 'p.randState', 4, ...
             'distn',   {'norme'},  'mu',          0,    'sigma',      [ 4 10 ], ...
             'nHidden', 425*8,      'hpl',         8,    'nConns',     12, ...
             ...% Input
             'ac.zscore', 0.05, ...
             'ac.tol',       0/3400, ... %tolerance for disconnected pixels
             ... % Training
             'ac.errorType', 2, ...
             'ac.XferFn',   [6 1],            'ac.useBias',  1, ...
             'ac.AvgError', 1E-5,             'ac.MaxIterations', 101, ...
             'ac.dropout', 0.5, ...
             'ac.TrainMode','resilient',      'ac.Pow', 1, ... %gradient power (usually 1)
             'ac.EtaInit',  2E-2,         'ac.Acc', 1E-7, 'ac.Dec', 0.25, ... 'ac.Acc', 1.001, 'ac.Dec', 1.15, ... %tanh#2, bias=1 resilient
             ...
             'ac.WeightInitScale', 0.01, ...
             'ac.wlim',     [-inf inf], ...
             'ac.noise_input', 0.00, ...
             'ac.lambda',   0.00, ...%[0.02 0.01],  ...% regularization
             ...
             'p.errorType', 2, ...
             'p.WeightInitScale', 0.005, ...
             'p.wlim', [-inf inf], ...
             'p.noise_input',     0.0,         ...% regularization
             'p.lambda',          0.0,         ...% regularization
             ... %rejections
             'ac.rej.props', {'err'},   'p.rej.props', {'err'}, ...
             'ac.rej.type',  {'max'},   'p.rej.type',  {'max'}, ...%sample_std-normd'}, ...
             'ac.rej.width', [nan],     'p.rej.width', [nan] ...
             ... %output
             'out.data', {'info','mat'}, ...
             'out.plots', {'png'}  ...
             'plots', {'ffts','connectivity','images','hu-encodings','hu-output'}, ...
             'stats', {'ffts','connectivity','images','hu-encodings','hu-output', 'ipd'}, ...
             ...
             varargin{:}
           };