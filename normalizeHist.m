function hist = normalizeHist(histogram)

% normalize the histogram
a = min(min(histogram));
b = max(max(histogram));
hist = (histogram - a)./ (b-a);