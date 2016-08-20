function [staticGraph] = generateStaticSimilarityGraph(staticMatrix1, staticMatrix2)

% get the number of histograms of the two action classes
[m1,~] = size(staticMatrix);
[m2,~] = size(staticMatrix2);
staticGraph =[];

% run the code for every pair of matrices
for i = 1:m
    Va = staticMatrix1(i,:);
    for j = 1:m
        Vb = staticMatrix2(j,:);
        K = getHistogramIntersection(Va, Vb);
        Q1 = getSpectralRespresentation(K);
        Q1 = Q1';
        staticGraph = [staticGraph;Q1];
    end
end
end