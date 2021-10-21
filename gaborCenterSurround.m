function output = gaborCenterSurround(input,nOfDir)
% output = gaborCenterSurround(input,nOfDir)
% compute the gabor pyramid based center-surround operation of the input in
% nOfDir numbers of directions equally dinstributed between 0 and 180°

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

[surroundMag, surroundPhase] = gaborPyramid(input,8,nOfDir);
centerMag = surroundMag;
centerPhase =  surroundPhase;
for j=1:nOfDir
    for c=2:4
        for delta=3:4
            reCenter = centerMag{j,c}.*cos(centerPhase{j,c});
            imCenter = centerMag{j,c}.*sin(centerPhase{j,c});
            reSurround = surroundMag{j,c+delta}.*cos(surroundPhase{j,...
                c+delta});
            imSurround = surroundMag{j,c+delta}.*sin(surroundPhase{j,...
                c+delta});
            reOutput = reCenter-reSurround;
            imOutput = imCenter-imSurround;
            output{j,2*c+delta-6} = sqrt(reOutput.^2+imOutput.^2);
        end
    end
end
end