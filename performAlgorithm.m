function performAlgorithm(sceneMatrix, motionMatrix)

% put the 
ka = 4;
ks= 22;
lambda = 1000;
fisher_vector = zeros(10, 2);
fisher_vector_1 = zeros(10,2);

% comapre DAKM and kMeans
for i = 1:10
    [fisher_vector(i,:), fisher_vector_1(i,:)] = runIterations(sceneMatrix, motionMatrix, ka, ks, lambda, 1);
end

% get the action and scene vectors
fa = fisher_vector(:,1);
fs = fisher_vector(:,2);

% get the action and scene vectors
fa_vec = fisher_vector_1(:,1);
fs_vec = fisher_vector_1(:,2);

% get the action graph
k = 1:10;
figure;
plot(k,fa, 'color', [1,0,1],  'Linestyle', '-');
hold on;
plot(k, fa_vec, 'color', [0,1,0], 'Linestyle', '--');
xlabel('Number of iterations');
ylabel('Max Action Discriminant');
legend('DAKM', 'kMeans');
hold off;

% get the scene graph
figure;
plot(k,fs, 'color', [1,0,1], 'Linestyle', '-');
hold on;
plot(k,fs_vec, 'color', [0,1,0], 'Linestyle', '--');
xlabel('Number of iterations');
ylabel('Max Scene Discriminant');
legend('DAKM', 'kMeans');
hold off;

end