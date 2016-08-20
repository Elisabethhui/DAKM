function [motionGraph] = generateMotionSimilarityGraph(motionMatrix1, motionMatrix2)

% get the number of histograms of the two action classes
[m1,~] = size(motionMatrix1);
[m2,~] = size(motionMatrix2);
motionGraph = [];

% run the code for every pair of matrices
for i = 1:4:m1-3
    Va = motionMatrix1(i:i+3,:);
    for j = 1:4:m2-3
        Vb = motionMatrix2(j:j+3,:);
        K = getHistogramIntersection(Va, Vb);
        Q1 = getSpectralRespresentation(K);
        Q1 = Q1';
        motionGraph = [motionGraph; Q1];
    end
end
end