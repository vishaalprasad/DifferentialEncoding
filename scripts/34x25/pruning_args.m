function [cargs,copts] = pruning_args(varargin)

  [cargs,copts] = uber_args( ...
            'runs',    40, ...
            ...
            'ac.ct.dataset',   'natimg', ...
            'ac.ct.steps',     {[8 8 8 8] [1 1 1 1]}, ...
            'ac.ct.npruning_loops', 4, ... %the rest of the loops in iters_per are training only
            'ac.ct.iters_per',   {[10 10 10 10] [10 10 10 10]}, ...
            'ac.ct.ac.AvgError',  0, ...
            'ac.ct.ac.TrainMode', 'resilient', ...
            'ac.ct.ac.Pow',       1, ...
            'ac.ct.ac.EtaInitInit', 2E-2, ...%.4, ...
            'ac.ct.ac.Acc',       5E-5, ...
            'ac.ct.ac.Dec',       0.25, ...
            'ac.ct.ac.lambda',    0.025, ...
            'ac.ct.ac.prune_loc', 'input', ...
            'ac.ct.ac.prune_strategy', 'weights', ...
            'ac.ct.ac.nzc_ok', false, ... %non-zero connections ok
            'ac.ct.keep_weights', true, ...
            varargin{:} ...
           );

  % stolen
  cargs = { 'ac.ct.deType',                 argval(cargs, 'deType'), ...
            'ac.ct.nConnPerHidden_Start',   2*argval(cargs,'nConns'), ...
            'ac.ct.sigma',                  [1 1]*argval(cargs,'sigma', 2), ...
            'ac.ct.ac.XferFn',              argval(cargs,'ac.XferFn'), ...
            'ac.ct.ac.zscore',              argval(cargs,'ac.zscore'), ...
            'ac.ct.ac.wlim',                argval(cargs,'ac.wlim'), ...
            'ac.ct.ac.WeightInitType',      argval(cargs,'ac.WeightInitType'), ...
            'ac.ct.ac.WeightInitScale',     argval(cargs,'ac.WeightInitScale'), ...
            'ac.ct.ac.noise_input',         argval(cargs,'ac.noise_input'), ...
             ...
             cargs{:} ...
           };



function val = argval(args,str,subidx)
%

  argidx = find(guru_findstr(args,str)==1,1,'last');
  if isempty(argidx), error('%s not found in arglist; must be present to push to pruning ac.', str); end;

  val = args{argidx+1};
  if exist('subidx','var'), val = val(subidx); end;
