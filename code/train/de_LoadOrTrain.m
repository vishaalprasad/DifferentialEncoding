function model = de_LoadOrTrain(model)
%
% Figures out whether ac or p needs to be trained.
%   If so, trains 'em up
%   If not, loads results metadata from disk
% Output model is the 'clean' version without 'heavy' props
%
% How to do attentional training:
%   * Try to load with flags.
%   * If that fails, then load without the flags, then pass in (how to indicate to skip first training?).

  % Force the separate training of the non-task-based images
  if isfield(model.ac, 'train_on_task_images') && model.ac.train_on_task_images
      guru_assert(strcmp(model.deType, 'de'), 'train_on_task_images is only supported currently for the de training type.');

      % Just load/train on the previous autoencoder result
      pre_train_model = guru_rmfield(model, 'p');
      pre_train_model.ac.train_on_task_images = false;
      pre_train_model = de_LoadOrTrain(pre_train_model);

      % Now load/train on the full thing
      model.ac = pre_train_model.ac;
      model.ac.train_on_task_images = true;
      model.ac.cached = false;
      model.ac.continue = true;
      %model = guru_rmfield(model, 'uberpath'); % is this necessary?


  %% Load autoencoder weights, if they exist
  elseif (  ~model.ac.continue ...
     && exist(de_GetOutFile(model, 'ac'),         'file') ...
     && exist(de_GetOutFile(model, 'ac.weights'), 'file'))

    model.ac.fn     = de_GetOutFile(model, 'ac');
    model.ac        = guru_loadVars(model.ac.fn, 'ac');
    model.ac.cached = 1;

    if (exist(de_GetOutFile(model,'ac.err'),   'file')), model.ac.err    = guru_loadVars(de_GetOutFile(model,'ac.err'),'err'); end;
    if (~isfield(model, 'uberpath'))
        if (exist(de_GetOutFile(model,'ac.output'),'file')), model.ac.output = guru_loadVars(de_GetOutFile(model,'ac.output'),'output'); end;
        if (exist(de_GetOutFile(model,'ac.hu'),    'file')), model.ac.hu     = guru_loadVars(de_GetOutFile(model,'ac.hu'),'hu'); end;
    end;

    % The "uber" variables don't necessarily correspond to the current variables,
    %   so these outputs may be invalid.  Remove them to make sure they're re-calculated.
    % How to deal with uber options vs our options (i.e. dnw)?
    if (isfield(model, 'uberpath'))
       model.ac = guru_rmfield(model.ac,'hu');
       model.ac = guru_rmfield(model.ac,'output');
    end;

  elseif (isfield(model, 'uberpath'))
    error('Uberfile %s not found.', de_GetOutFile(model, 'ac'));

  % Gotta train...
  else
    model.ac.cached = 0;
  end;

  % Load perceptron, if exists
  if (isfield(model, 'p'))
      if (   ~model.p.continue ...
          && exist(de_GetOutFile(model, 'p'),          'file') ...
          && exist(de_GetOutFile(model, 'p.weights'),  'file'))% ...
%          && exist(de_GetOutFile(model, 'p.output'),   'file'))
        model.p        = guru_loadVars(de_GetOutFile(model, 'p'),  'p');
        model.p.cached = 1;
      else
        model.p.cached = 0;
      end;
  end;

  switch (model.deType)
    case 'de',         model = de_DE     (model);
    case 'de-deep',    model = de_DE_Deep(model);
    case 'de-mtl',     model = de_DE_MTL(model);
    case 'de-stacked', model = de_DE_Stacked(model);
    otherwise, error('Unknown DE type: %s', model.deType);
  end;

  % Stamp filename
  if (~isfield(model.ac,'fn'))
      model.ac.fn = de_GetOutFile(model, 'ac');
  end;

  % Report total time
  trainTime = 0;
  if (model.ac.cached == 0), trainTime = trainTime + model.ac.trainTime(end); end;
  if (isfield(model, 'p') && model.p.cached == 0),  trainTime = trainTime + model.p.trainTime(end);  end;


  %fprintf(' | t: %5.1fs (%5.1fs', trainTime, model.ac.trainTime);
  %if (isfield(model, 'p')), fprintf('+ %5.1fs', model.p.trainTime); end;
  %fprintf(')');
