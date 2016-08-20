function mu = updateCentroids(X, idX, k)

% the mean vector containing the mean of each cluster
mu = zeros(k, size(X,2));
for i = 1:k
    % find the cluster
    ids = find(i==idX);
    if ~isempty(ids)
        % update the mean of the cluster
        mu(i,:) = sum(X(ids,:),1)/numel(ids);
    end
end
end
