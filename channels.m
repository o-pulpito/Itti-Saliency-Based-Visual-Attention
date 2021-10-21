function [I,R,G,B,Y] = channels(input)
%[I,R,G,B,Y] = channels(input)
% produces the intensity I map and the R,G,B and Y channels of the input
% image

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

I = (input(:,:,1)+input(:,:,2)+input(:,:,3))/3;
maxI = max(I(:));
r = (I>maxI/10).*input(:,:,1)./I;
g = (I>maxI/10).*input(:,:,2)./I;
b = (I>maxI/10).*input(:,:,3)./I;
R = r-(g+b)/2;
R = R.*(R>0);
G = g-(r+b)/2;
G = G.*(G>0);
B = b-(r+g)/2;
B = B.*(B>0);
Y = (r+g)/2-abs(r-g)/2-b;
Y = Y.*(Y>0);
end