function [IDx, mu, R] = DAKM(d, k, lambda, iter)
%function [IDx, mu] = DAKM(d, k, iter)

% initial clustring
origIDx = cell(2,1);
origmu = cell(2,1);

for i = 1:2
    [origIDx{i}, origmu{i}] = kmeans(d{i}, k{i}, 'maxIter', iter);
end

% starting with initial configurations
IDx = origIDx;
mu = origmu;
t = 0;


% initialize the new configureations
oldIDx{1} = zeros(size(IDx{1}));
oldIDx{2} = zeros(size(IDx{2}));

% intialize the values of R
R = zeros(k{1}, k{2}) + 1./(k{1}*k{2});

% update while Cx and Cy do not change
while((any(oldIDx{1} ~= IDx{1}) && any(oldIDx{2} ~= IDx{2})) && t < iter)
    % save the current value of Cx, Cy
    oldIDx = IDx;
    % update the relationship
    R = updateRelationship(IDx, k, lambda);
    % update the membership of actions and scenes
    IDx = updateMembership(d, mu, R);
    % update the centroids
    for i = 1:2
        mu{i} = updateCentroids(d{i}, IDx{i}, k{i});
    end
    % keep track of the number of iterations
    t = t+1;
end

% finally update the membership once again
IDx = updateMembership(d, mu, R);
for i = 1:2
    % update the centroids of the clusters
    % after the final membership updates
    mu{i} = updateCentroids(d{i}, IDx{i}, k{i});
end

fprintf('Finished after %d iterations\n', t);
end