function [cargs] = common_args_pruning(varargin)


  cargs = { 'ac.ct.dataset',   'natimg', ...
            'ac.ct.steps',     {[8 8 8 8] [1 1 1 1]}, ...
            'ac.ct.npruning_loops', 4, ... %the rest of the loops in iters_per are training only,     {[6 5 4 3 1] [2 2 1 1 1]}, ...
            'ac.ct.iters_per',   {[10 10 10 10] [10 10 10 10]}, ...%'ac.ct.iters_per_step', [15 1], ...
            'ac.ct.ac.AvgError',  0, ...
            'ac.ct.ac.TrainMode', 'resilient', ...
            'ac.ct.ac.Pow',       1, ...
            'ac.ct.ac.EtaInitInit', 2E-2, ...%.4, ...
            'ac.ct.ac.Acc',       5E-5, ...
            'ac.ct.ac.Dec',       0.25, ...
            'ac.ct.ac.XferFn',    [6 1], ...
            'ac.ct.ac.lambda',    0.025, ...
            'ac.ct.ac.wlim',      2*[-1 1], ...
            'ac.ct.ac.WeightInitType', 'sprand', ...
            'ac.ct.ac.WeightInitScale', 0.01, ...
            'ac.ct.ac.prune_loc', 'input', ...
            'ac.ct.ac.prune_strategy', 'weights', ...
            'ac.ct.ac.nzc_ok', false, ... %non-zero connections ok
            'ac.ct.keep_weights', true, ...
            'ac.ct.ac.noise_input',0.0001 ...
             ...
             varargin{:}
           };
