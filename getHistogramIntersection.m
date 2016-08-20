function K = getHistogramIntersection(A,B)

% normalize the histogram
A = normalizeHist(A);
B = normalizeHist(B);

% get the size of the new intersection histogram
a = size(A,2); 
b = size(B,2);
K = zeros(a,b);

% get the intersection histogram
for i = 1:a
  Va = repmat(A(:,i),1,b);
  K(i,:) = 0.5*sum(Va + B - abs(Va - B));
end
end