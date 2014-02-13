function [mean_mean_nn_dist,mean_nn_dist,min_nn_dist] = estimate_min_spread(model,npts)
if ~exist('npts','var'), npts = 33; end;

mean_nn_dist = zeros(npts,1);
min_nn_dist = zeros(npts,model.nConns);
for ii=1:npts
    if false % discrete case
        all_conns = de_connect_random(model);
        hu_conns = reshape(all_conns(prod(model.nInput)+2, 1:prod(model.nInput)), model.nInput);%de_connector2D([35 35],1,1,5,'norme',nan,5,1:10,1);%,weight_factor, want_fully
        [mean_nn_dist(ii),~,nn_dist(ii,:)] = de_calc_nn_dist(hu_conns);
        %figure; imshow(full(reshape(hu_conns, nInput)));

    else % continuous case
        all_samps = mvnrnd([0 0], [1.5 0.75]*model.sigma, model.nConns);
        [mean_nn_dist(ii),min_nn_dist(ii,:)] = de_calc_nn_dist(all_samps(:,1), all_samps(:,2));
    end;
end;

mean_mean_nn_dist = mean(mean_nn_dist);