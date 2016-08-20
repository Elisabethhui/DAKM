function IDx = updateMembership(d, mu, R)

% create am empty cell
D = cell(2,1);
for i=1:2
    D{i} = pdist2(d{i}, mu{i});
end

% Let the two clusters that have their relationship 
% be X and Y
[X,Y] = find(R>0);
fD = zeros(size(D{1},1), numel(X));
for i = 1:numel(X)
    % finding the distance of the new point from the existing clusters
    % divide by the value of R to normalize
    fD(:,i) = ((D{1}(:,X(i))).*(D{2}(:,Y(i))))./(R(X(i),Y(i)));
end

% find the of j,l that minimize the distance from the two clusters
[~, ind] = min(fD, [], 2);
% update the values of the clusters X and Y
IDx{1} = X(ind);
IDx{2} = Y(ind);
end
