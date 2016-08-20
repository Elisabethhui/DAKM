function [motionHist] = getMotionFeatures(matrix)

% function returns a 4x500 histogram for
% each of HOG, HOF, MBH, Tr each feature
% giving 1x500 histogram

% getting the features from the matrix
traj = matrix(:, 11:40);
hog = matrix(:, 41:136);
hof = matrix(:, 137:244);
mbh = matrix(:, 245:341);

% normalize the features
traj_norm = (traj - min(min(traj)))/(max(max(traj)) - min(min(traj)));
hog_norm = (hog - min(min(hog)))/(max(max(hog)) - min(min(hog)));
hof_norm = (hof - min(min(hof)))/(max(max(hof)) - min(min(hof)));
mbh_norm = (mbh - min(min(mbh)))/(max(max(mbh)) - min(min(mbh)));

traj_norm = traj_norm';
hog_norm = hog_norm';
hof_norm = hof_norm';
mbh_norm = mbh_norm';

% get the PCA with 95 percent variance
[coeff_traj] = pca(traj_norm, 'VariableWeights', var(traj_norm));
[coeff_hog] = pca(hog_norm, 'VariableWeights', var(hog_norm));
[coeff_hof] = pca(hof_norm, 'VariableWeights', var(hof_norm));
[coeff_mbh] = pca(mbh_norm, 'VariableWeights', var(mbh_norm));

k_traj = kmeans(coeff_traj, 500, 'MaxIter', 250);
k_hog = kmeans(coeff_hog, 500, 'MaxIter', 250);
k_hof = kmeans(coeff_hof, 500, 'MaxIter', 250);
k_mbh = kmeans(coeff_mbh, 500, 'MaxIter', 250);

% the frequency histogram
motionHist = zeros(1,500);

% construct the frequency histrogram
motionHist(1, :) = hist(k_hog, 500);
motionHist(2, :) = hist(k_hof, 500);
motionHist(3, :) = hist(k_mbh, 500);
motionHist(4, :) = hist(k_traj, 500);
