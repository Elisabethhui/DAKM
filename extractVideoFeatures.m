function [actionHist, sceneHist] = extractVideoFeatures(video, motionMatrix)

% get the motion features of a video
actionist = getMotionFeatures(motionMatrix);
% get the static features of a video
sceneHist = getSceneFeatures(video);