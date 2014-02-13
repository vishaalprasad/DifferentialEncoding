function [outFile] = de_GetDataFile(expt, stimSet, taskType, opt, stem, fileType, outdir)
%
%
%

  if (~exist('stem',   'var') || (isempty(stem) && ~ischar(stem))),         stem     = sprintf('data_%s', expt); end;
  if (~exist('fileType','var')|| (isempty(fileType) && ~ischar(fileType))), fileType = 'mat'; end;
  if (~exist('outdir','var')  || (isempty(outdir) && ~ischar(outdir))),     outdir   = fullfile(de_GetOutPath([], 'data'), sprintf('%s.%s', expt, stimSet)); end;

  if (isempty(taskType)), taskType = 'stimonly'; end;
  
  switch (fileType)
    case 'mat'
      outStem = sprintf('%s.%s.%s', stem, stimSet, taskType);
      if (~isempty(opt))
          outStem = [outStem '.' guru_cell2str(opt, '.')];
      end;
      
      outFile = [outStem '.mat'];  

    case 'dir'
      outFile = sprintf('%s-%s', stem, stimSet);

    otherwise
      error('Unknown file type: %s', fileType);
  end;
  
  % Normailze weirdness
  outFile = regexprep(outFile, '\.+', '.'); %normalize periods
  outFile = regexprep(outFile, '\s+', ' '); %normalize whitespace
  outFile = regexprep(outFile, '\{\.', '{'); %normalize {. to {
  
  outFile = fullfile(outdir, outFile);