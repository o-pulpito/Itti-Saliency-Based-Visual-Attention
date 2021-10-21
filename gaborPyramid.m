function [outputMag, outputPhase] = gaborPyramid(input,l,nOfDir)
% [outputMag, outputPhase] = gaborPyramid(input,l,nOfDir)
% compute the l-th level gabor pyramid of the input, where l=0 is the
% base image, l=1 is the first reduction, etc... while nOfDir is the number
% of directions if interest equally dinstributed between 0 and 180°

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

for j=1:nOfDir
    outputMag{j,1} = input;
    for i=1:l-1
        theta = round(180/nOfDir*(j-1));
        [mag, phase] = imgaborfilt(input,2^i,theta);
        outputMag{j,i+1} = mag;
        outputPhase{j,i+1} = phase;
    end
end
end