function output = conspicuityOr(input,M)
% output = conspicuityOr(input,M)
% produces the orientation conspicuity map of the orientation 
% center-surround maps in input
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
[nOfDir,nOfMaps] = size(inputNorm);
[hScale,wScale] = size(inputNorm{end,end});
output = zeros(hScale,wScale);
for j=1:nOfDir
    temp = zeros(hScale,wScale);
    for i=1:nOfMaps
        temp = temp+inputNorm{j,i};
    end
    output = output+singleMapNormalization(temp,M);
end
output = imresize(output,1/2^(4-1));
end