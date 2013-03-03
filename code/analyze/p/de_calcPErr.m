function err = de_calcPErr(o_p, T, errorType)
% 
% Takes some matrix of outputs over a # of iterations
%   and a matrix of expected outputs.
% Computes the error over all output nodes
%   for each iteration

  nModels = size(o_p,1);
  goodTrials = ~isnan(sum(T,1));
  vecT    = reshape(T(:,goodTrials), [1 numel(T(:,goodTrials))]);
  matT    = repmat(vecT, [nModels 1]);
  err     = emo_nnError(errorType, o_p, matT); %o_p - matT, o_p, matT);

%  if (size(T,1) ~= 1)
%    err     = reshape(err, [nModels size(T)]);
%    % Why averaging here?
%    %err     = reshape(nan_mean(err, 2), [nModels size(T,2)]);
%  end;
