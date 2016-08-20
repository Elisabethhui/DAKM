function [F, D] = getSIFTFeatures(videoInput)

F = [];
D = [];
% get the video
objVideo = VideoReader(videoInput);
numFrames = objVideo.NumberOfFrames;
% for interval of 10 frames 
for i = 1:10:numFrames
    % get the current frame
    currFrame = read(objVideo, i);
    I = single(rgb2gray(currFrame)/256);
    % extract sift features
    [f,d] = vl_sift(I);
    F = [F f];
    D = [D d];
end
D = double(D);