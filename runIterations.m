function [IDx, mu, R, fisher] = runIterations(sceneMatrix, actionMatrix, ka, ks, lambda)

% cell for k
k = cell(2,1);
k{1} = ka;
k{2} = ks;

% max number of iterations for convergence
its = 1000;
d = cell(2,1);
d{1} = actionMatrix;
d{2} = sceneMatrix;

[IDx, mu, R] = DAKM(d, k, lambda, its);

% fisher analysis
fisher = cell(2,1);
%fisher = zeros(2,1);
fa = fisherAnalysis(IDx{1}, actionMatrix, k{1});
fs = fisherAnalysis(IDx{2}, sceneMatrix, k{2});

fisher{1} = fa;
fisher{2} = fs;

%{
if(options == 0)
    min_fa = min(fa(:));
    min_fs = min(fs(:));
    fisher(1) = min_fa;
    fisher(2) = min_fs;
end

% get max
if (options == 1)
    max_fa = max(fa(:));
    max_fs = max(fs(:));
    fisher(1) = max_fa;
    fisher(2) = max_fs;
end
fisher = fisher';

% fisher of kmeans 
cidx = kmeans(sceneMatrix,k{2});
fisher_scene = fisherAnalysis(cidx, sceneMatrix, k{2});
fisher_scene = max(fisher_scene(:));

cidx = kmeans(actionMatrix,k{1});
fisher_motion = fisherAnalysis(cidx, actionMatrix, k{1});
fisher_motion = max(fisher_motion(:));

fisher_vec = [fisher_motion; fisher_scene];
fisher_vec = fisher_vec';
%}
end