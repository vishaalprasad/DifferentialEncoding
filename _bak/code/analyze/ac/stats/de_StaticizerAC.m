function [stats] = de_StaticizerAC(mSets, mss, s)  
%

  % 3rd arg can be a list of plots, or can be the old stats
  if (exist('s','var'))
      if     (iscell(s)),   stc = s; 
      elseif (isstruct(s)), stats = s; end;
  end;
  if (~exist('stc','var')),  stc = mSets.stats; end;
  if (~exist('stats','var')), stats = []; end;

  % Default set of stats
  if (guru_contains('default', stc))
    default_stats = {'err', 'tt', 'ti'};
    stc = setdiff(unique([stc default_stats]), {'default'});
  end;
  

  % Basic stats
  if (~isfield(mSets.data, 'err')), [stats] = de_DoStat('err', stats, 'err', stc, 'de_StatsTrainErrorAC', mss); end;
  if (~isfield(mSets.data, 'tt')),  [stats] = de_DoStat('tt',  stats, 'tt',  stc, 'de_StatsTrainTimeAC',  mss); end;
  if (~isfield(mSets.data, 'ti')),  [stats] = de_DoStat('ti',  stats, 'ti',  stc, 'de_StatsTrainItersAC', mss); end;
  if (~isfield(mSets.data, 'ipd')), [stats] = de_DoStat('ipd', stats, 'ipd', stc, 'de_StatsInterpatchDistance', mss); end;
  
  % Optional stats
  if (~isfield(stats, 'ffts')), stats.ffts = []; end;
  if (isfield(mSets.data, 'test')), [stats.ffts] = de_DoStat('ffts', stats.ffts, 'test',  stc, 'de_StatsFFTs', mss, mSets.data.test);
  else,                             [stats.ffts] = de_DoStat('ffts', stats.ffts, 'train', stc, 'de_StatsFFTs', mss, mSets.data.train); end;

  if (~isfield(stats, 'huencs')), stats.huencs = []; end;
  if (isfield(mSets.data, 'test')), [stats.huencs] = de_DoStat('huencs', stats.huencs, 'test',  stc, 'de_StatsHUEncodings', mss, mSets.data.test);
  else,                             [stats.huencs] = de_DoStat('huencs', stats.huencs, 'train', stc, 'de_StatsHUEncodings', mss, mSets.data.train); end;

  if (~isfield(stats, 'huouts')), stats.huouts = []; end;
  if (isfield(mSets.data, 'test')), [stats.huouts] = de_DoStat('huouts', stats.huouts, 'test',  stc, 'de_StatsHUOutputs', mss, mSets.data.test);
  else,                             [stats.huouts] = de_DoStat('huouts', stats.huouts, 'train', stc, 'de_StatsHUOutputs', mss, mSets.data.train); end;