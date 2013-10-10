function [fig] = de_PlotOutputImagesThreshd(models, dset)
%function [fig] = de_PlotOutputImagesThreshd(models)
%
% Show the average or instance connectivity of a model
%
% Input:
% model         : see de_model for details
%
% Output:
% h             : array of handles to plots

  % Plot 1: show trend of encoding error, according to type (Reza's plots)
  %   This plot will show outliers as spikes.
  % Create old-style info

  nDims   = length(models(1).nInput);

  switch (nDims)
%      case 1, de_PlotOutputImages_Instance1D(models{i}(1), hpl, mu);
    case 2, fig = de_PlotOutputImagesThreshd_Instance2D(models(1), dset);
  end;

  switch (nDims)
%      case 1, de_PlotOutputImages_Average1D(models{i}, hpl, mu);
%      case 2, fig(end+1) = de_PlotOutputImages_Average2D(models{i}, dset);
  end;
 
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  function de_PlotOutputImagesThreshd_2D( o, obj, t)
  %2d plot
  
    plotNum = 1;
    nImages = size(o,2);
    [nRows,nCols] = guru_optSubplots(nImages);
    
    for i=1:nImages
      img = reshape(o(:,i), obj.nInput);
      
      % Plot the connectivity pattern
      subplot(nRows, nCols, i);
      colormap(gray);
      imagesc(img);
      hold on;

      set(gca, 'xtick',[],'ytick',[]);
      xlabel(sprintf('%s: (%s)', obj.XLAB{i}, obj.TLAB{i}));
    end;
    
    %
    hold on;
    mfe_suptitle(t);
      
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  function fig = de_PlotOutputImagesThreshd_Instance2D(model, dset)
  %2d plot
    fig = de_NewFig('images-threshd-inst', 'images', dset);
    
    model = de_LoadProps(model, 'ac', 'Weights');
    
    [o]   = guru_nnExec(model.ac, dset.X, dset.X);
    o = double(o >= 0.5);    

    de_PlotOutputImagesThreshd_2D( ...
        o,...
        dset, ...
        sprintf('Instance image plot, o=%4.1f', model.sigma) ...
      );
    