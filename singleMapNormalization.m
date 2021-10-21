function output = singleMapNormalization(input,M)
% normalizes the input map by:
% - normalizing it from 0 to M;
% - assigning to a variable m the average local maxima (excluded M);
% - normalizing again in a range from 0 to (M-m)^2

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

dynamicLimited = (input-min(input(:)))./(max(input(:))-min(input(:))).*M;
noGlobalMax = dynamicLimited.*(dynamicLimited<M);
localMaxima = nonzeros(noGlobalMax.*islocalmax(noGlobalMax));
m = mean(localMaxima);
output = dynamicLimited*(M-m)^2;
end