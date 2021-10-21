function output = gaussianCenterSurround(input1,input2)
% output = gaussianCenterSurround(input1,input2)
% compute the gaussian pyramid based center-surround operation between the
% input1 and the input 2;
% the inputs must be of the same size

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

center = gaussianPyramid(input1,4);
surround = gaussianPyramid(input2,8);
for c=2:4
    for delta=3:4
        centerSize = size(center{c},1,2);
        surroundResize = imresize(surround{c+delta},centerSize);
        output{2*c+delta-6} = abs(center{c}-surroundResize);
    end
end
end