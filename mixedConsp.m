function output = mixedConsp(conspI,conspC,conspOr,M)
% output = ittiSaliency(conspI,conspC,conspOr,M)
% produces the overall saliency map by averaging the intensity, color and
% orientation conspicuity maps
% M is the normalization value according to the normalization function
% proposed by Itti et al.

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

conspINorm = singleMapNormalization(conspI,M);
conspCNorm = singleMapNormalization(conspC,M);
conspOrNorm = singleMapNormalization(conspOr,M);
output = 1/3*(conspINorm+conspCNorm+conspOrNorm);
end