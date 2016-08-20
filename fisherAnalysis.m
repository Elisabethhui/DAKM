function [fisher] = fisherAnalysis(A, Data, k)

% get the unit vector
[~,n] = size(Data);
w = randn(n,1);
w = w./norm(w);

% get the unit vector
r = randn(2,1);
r = r./norm(r);

% the fisher matrix
fisher = zeros(k, k);

for i = 1:k
    % get the ith cluster
	clusteri = Data(A == i, :);
    [mi, ~] = size(clusteri);
	
    for j = i+1:k
        % get the jth cluster
		clusterj = Data(A == j, :);
        [mj,~] = size(clusterj);
        if(mj > mi)
            new_clusteri = [clusteri; zeros(mj-mi, n)];
            % get the fisher terms
            withinClass = w'*cov(new_clusteri)*w;
            betweenClass = r'*cov(new_clusteri, clusterj)*r;
        else
            new_clusterj = [clusterj; zeros(mi-mj, n)];
            % get the fisher terms
            withinClass = w'*cov(clusteri)*w;
            betweenClass = r'*cov(clusteri, new_clusterj)*r;
        end
        % calculate the discriminant
		discriminant = betweenClass/withinClass;
		fisher(i,j) = discriminant;
    end
    % put the ith discriminant
    fisher(i,i) = withinClass;
end
