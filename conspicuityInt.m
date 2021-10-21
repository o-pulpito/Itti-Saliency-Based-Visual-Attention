function output = conspicuityInt(input,M)
% output = conspicuityInt(input,M)
% produces the intensity conspicuity map of the intensity center-surround
% maps in input
% M is the normalization value according to the normalization function
% proposed by Itti et al.

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

inputNorm = mapNormalization(input,M);
[nOfMaps] = size(inputNorm,2);
[hScale4,wScale4] = size(inputNorm{end,end});
output = zeros(hScale4,wScale4);
for i=1:nOfMaps
    mapResize = imresize(inputNorm{1,i},[hScale4 wScale4]);
    output = output+mapResize;
end
end