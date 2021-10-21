function [varargout] = ittiSaliency(input)
% [saliencyCoord,saliencyMap,conspI,conspC,conspOr,CSI,RG,BY,orientationMaps,I,R,G,B,Y] = ittiSaliency(image);
% Computes the all process described in the rerence article:
% 1. Devides the input image in I,R,G,B and Y channels as described in
%    par. 2.1
% 2. Computes the center-surround operation on the Intensity channel and
%    the RG and BY double opponencies as described in par 2.1
% 3. Computes the 4 orientation center-surround operation as described
%    in par 2.1
% 4. Produces the conspicuity maps of intensity, color and orientation
%    as described in par 2.2
% 5. Produces the saliency map as described in par 2.2
% 6. Extracts the saliency points with the Winner-Take-All and Inibition of
%    Return strategy proposed in par 2.2 - Note: This is just my 
%    interpretation of the WTA section. It is not based on the leaky
%    integrate-and-fire neuron model. I could not find any implementation
%    of this kind of model. Please, let me know if it looks correct to you
%    or if you got any suggestion or if you have the correct version of the
%    model proposed by Itti et al.

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

%% Channel division

[I,R,G,B,Y] = channels(input);

%% Center-Surround operation on the intensity channel

CSI = gaussianCenterSurround(I,I);

%% RG and BY opponency

RG = gaussianCenterSurround(R-G,G-R); 
BY = gaussianCenterSurround(B-Y,Y-B);

%% orientation maps

orientationMaps = gaborCenterSurround(I,4);

%% Conspicuity maps

conspI = conspicuityInt(CSI,1);
conspC = conspicuityCol(RG,BY,1);
conspOr = conspicuityOr(orientationMaps,1);

%% Overall saliency map

saliencyMap = mixedConsp(conspI,conspC,conspOr,1);

%% A Winner-Take-All implementation

saliencyCoord = winnerTakeAll(saliencyMap,true);

%% Outputs
varargout{1} = saliencyCoord;
varargout{2} = saliencyMap;
varargout{3} = conspI;
varargout{4} = conspC;
varargout{5} = conspOr;
varargout{6} = CSI;
varargout{7} = RG;
varargout{8} = BY;
varargout{9} = orientationMaps;
varargout{10} = I;
varargout{11} = R;
varargout{12} = G;
varargout{13} = B;
varargout{14} = Y;

end