function output = inibitionOfReturn(input,previousWinner)
% output = inibitionOfReturn(input,previousWinner)
% Sets the pixel near the previousWinner coordinates to zero in order to
% avoid returns in the next iteration.

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

[w,h] = size(input);
r = min(w,h)/10;
x = 1:w;
y = 1:h;
X = repmat(x',1,h);
Y = repmat(y,w,1);
rho = sqrt((X-previousWinner(1)).^2+(Y-previousWinner(2)).^2);
output = input.*(rho>r);
end