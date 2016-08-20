function [Q1] = getSpectralRespresentation(K)

% get the svd of the spectral representation
[Q1,S,~] = svd(K);
eigVal = diag(S);
[~,n] = size(eigVal);
threshold = zeros(n,1);
for i = 1:n
    threshold(i) = sum(eigVal(1:i));
end
threshold = threshold./threshold(end);
% find top k singular vector
k = find(threshold > 0.99999999, 1);
Q1 = Q1(:,1:k);
end