function output = gaussianPyramid(input,l)
% output = gaussianPyramid(input,l)
% compute the l-th level gassian pyramid of the input, where l=0 is the
% base image, l=1 is the first reduction, etc...

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

output{1} = input;
for i=1:l-1
    output{i+1} = impyramid(output{i},'reduce');
end
