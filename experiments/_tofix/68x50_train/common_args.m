function [cargs, opt] = common_args(varargin)

  % Add absolute path to code
  if (exist('de_GetBaseDir')~=2)
    addpath(genpath(fullfile('..','..', 'code')));
    addpath(genpath(fullfile('..','..','..', 'code')));
    addpath(genpath(fullfile(de_GetBaseDir(),'code')));
    rmpath (genpath(fullfile('..','..','..', 'code')));
    rmpath (genpath(fullfile('..','..', 'code')));
  end;

  c_dset = 'uber';
  opt    = {'medium'};% 'xdnw' c_dset};

  cargs = {  'debug', 1:10, 'ac.debug', 1:10 ...
             ... %
             'distn',   {'norm'},  'mu',          0,    'sigma',     [ 5.9 6.0 ], ...
             'nHidden', 425*2     'hpl',          2,    'nConns',    6, ...
             ... %
             'ac.ct.dataset',   c_dset, ...
                'ac.ct.steps',     {[16 16 12 8 1 1 1 1] [16 16 12 8 1 1 1 1]}, ...
                'ac.ct.npruning_loops', 4, ... %steps',     {[6 5 4 3 1] [2 2 1 1 1]}, ...
                'ac.ct.iters_per',   {[15 15 15 15 5 5 5 5] [5 5 5 5 15 15 15 15]}, ...%'ac.ct.iters_per_step', [15 1], ...
                'ac.ct.ac.AvgError',  0, ...
                'ac.ct.ac.TrainMode', 'batch', ...
                'ac.ct.ac.Pow',       1, ...
                'ac.ct.ac.EtaInitInit', 0.025, ...%.4, ...
                'ac.ct.ac.Acc',       1.005, ...
                'ac.ct.ac.Dec',       1.5, ...
                'ac.ct.ac.XferFn',    6, ...
                'ac.ct.ac.lambda',    0.025, ...
                'ac.ct.ac.wmax',      inf ...
                'ac.ct.ac.WeightInitType', 'sprand', ...
                'ac.ct.ac.WeightInitScale', 0.01, ...
                'ac.ct.ac.prune_loc', 'output', ...
                'ac.ct.ac.prune_strategy', 'weighted_weights', ...
                'ac.ct.ac.nzc_ok', false, ... %non-zero connections ok
             ...% Input
             'ac.zscore', true, ...
             'ac.randState', 4, ...
             'ac.tol',       0/850, ... %tolerance for disconnected pixels
             ... % Training
             'ac.XferFn',   6,            'ac.useBias',  1, ...
             'ac.AvgError', 0,            'ac.MaxIterations', 1, ...
             'ac.TrainMode','resilient',  'ac.Pow', 3,            ... %gradient power (usually 1)
             'ac.EtaInit',  3E-14,        'ac.Acc', 5E-5, 'ac.Dec', 0.01, ... %tanh#2, bias=1 resilient
             'ac.lambda',   0.0, ...                                    % regularization
             'ac.wmax',     inf, ...%1.00 ...
             ... %rejections
             'ac.rej.props', {'err'},   ...
             'ac.rej.type',  {'sample_std-normd'},   ...
             'ac.rej.width', [4],     ...
             ... %output
             'out.data', {'info','mat'}, ...
             'out.plots', {'png'}  ...
             ...
             varargin{:}
           };
%             'ac.TrainMode','resilient',  'ac.Pow', 1, ... %gradient power (usually 1)
%             'ac.EtaInit',  5E-3,         'ac.Acc', 5E-7, 'ac.Dec', 0.15, ... %tanh#2, bias=1 resilient