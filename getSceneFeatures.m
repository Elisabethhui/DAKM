function [histD] = getSceneFeatures(videoInput)

% number of clusters
k = 500;
% get SIFT features
[~, D] = getSIFTFeatures(videoInput);
% perfrom PCA using variance as weights
[coeffD] = pca(D, 'VariableWeights', var(D));
% perform kmeans for 500 clusters
descriptors = kmeans(coeffD, k);
% get the histogram of descriptors
histD = hist(descriptors, 500);