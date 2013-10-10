function [rejMats] = de_FindRejectionsP(mss, rejSets, stats, rejMats)
%
%

  if (~iscell(mss))
    mss = num2cell(mss, 1);
  end;

  nSigmas = length(mss);
  
  
  if (~exist('rejMats','var') || isempty(rejMats))
    rejMats = cell(nSigmas,1);
    for k=1:nSigmas
        rejMats = zeros(length(mss{k}), 0);
    end;
  end;
  
  for k=1:nSigmas
      rejMats{k}(:,end+1:end+3) = zeros(length(mss{k}), 3);
  
      rejMats{k}(:,end-2) = de_FindRejections_PerStat(mss{k}, de_GetRejSets(rejSets, 'err'), stats.p.err.vals{k});
      rejMats{k}(:,end-1) = de_FindRejections_PerStat(mss{k}, de_GetRejSets(rejSets, 'tt'),  stats.p.tt{k});
      rejMats{k}(:,end-0) = de_FindRejections_PerStat(mss{k}, de_GetRejSets(rejSets, 'ti'),  stats.p.ti{k});
  end;