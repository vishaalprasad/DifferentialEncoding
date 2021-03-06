function [ms,ss] = slotnick_interaction_analysis(tst_cate, tst_coor)
% See Slotnick, et al. 2001: Figure 2 for comparison.

  % Reconstitute into expected format
  ms.cate = tst_cate.models;
  ms.coor = tst_coor.models;
  ss.cate = tst_cate.stats;
  ss.coor = tst_coor.stats;
  mSets   = tst_cate.mSets;

  ss.group = de_StatsGroupBasicsSlot( mSets, ms, ss );
  [figs] = de_PlotGroupBasicsSlot(ms, ss);
  de_SavePlots(mSets, figs);
