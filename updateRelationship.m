function R = updateRelationship(IDx, k, lambda)

% intialize the R matrix
R = zeros(k{1}, k{2});
for i = 1:numel(IDx{1})
    R(IDx{1}(i), IDx{2}(i)) = R(IDx{1}(i),IDx{2}(i)) + 1;
end
% normalize the R
R = R ./ numel(IDx{1});

% Form the M vectors
M = cell(2,1);
for i = 1:2
    M{i} = zeros(k{i}, 1);
    for j = 1:k{i}
        % update the M vectors independant of the update of R
        M{i}(j) = sum(IDx{i} == j);
    end
    % mnormalise the M vectors
    M{i} = M{i}/numel(IDx{i});
end

% finding the value of R2
% this is the equation for Kronecker Product
R2 = M{1}*M{2}' + 1./(k{1}+k{2});
R2 = R2 ./ sum(sum(R2));

% finding the Hadamard Division
R = R ./ R2;
R = R ./ sum(sum(R));

% Regularize the R matrix
R = log(lambda*R+1);
R = R ./ sum(sum(R));
end
