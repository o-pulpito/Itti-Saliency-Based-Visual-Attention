function [saliencyCoord] = winnerTakeAll(saliencyMap,varargin)
% saliencyCoord = winnerTakeAll(saliencyMap,nOfSaliencies,isItti)

% Gives as output the most salient points coordinates according to the 
% saliencyMap in input. At each iteration, the region surrounding the 
% selected point is inibited by setting to zero a number of pixel of the
% saliency map (see inibitionOfReturn function). Further, if the 
% saliencyMap comes from the Itti et al. strategy, (isItti flag set to 
% true) we know that its dimensions have to be reset to (2^3)x as the maps
% are based on the 3rd level of the gaussian/gabor pyramid.

% Note: This is just my interpretation of the WTA section. It is not based
% on the leaky integrate-and-fire neuron model. I could not find any
% implementation of this kind of model. Please, let me know if it looks
% correct to you or if you got any suggestion or if you have the correct
% version of the model proposed by Itti et al.

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

maxSaliency = max(saliencyMap(:));
i = 1;
while max(saliencyMap(:))>.75*maxSaliency
    bwMap = saliencyMap==max(saliencyMap(:));
    [row,col] = find(bwMap,1);
    saliencyMap = inibitionOfReturn(saliencyMap,[row,col]); % it sets a
    % region surrounding the selected saliency to zero in order to avoid
    % returns
    saliencyCoord{1,i} = [row,col];
    % filtWindow = circFilter(1+1*level);
    % saliencyMap = conv2(saliencyMap,filtWindow,'same'); % it filters the
    % saliency map with a circular filter with growing dimensions. This 
    % step helps moving the attention towards other regions of the image
    i = i+1;
end
if (nargin==2) && (varargin{1}==true)
    for j=1:i-1
        saliencyCoord{j} = saliencyCoord{j}*2^3; % reset the coordinate to
        % the original dimensions of the image
    end
end
end