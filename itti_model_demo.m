clear; close all; clc;

% Reference: Itti, L., C. Koch, e E. Niebur. «A model of saliency-based
% visual attention for rapid scene analysis». IEEE Transactions on Pattern
% Analysis and Machine Intelligence 20, n. 11 (novembre 1998): 1254–59.
% https://doi.org/10.1109/34.730558.

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

%% Image loading

image = double(imread('road.jpg'));
imsize = [480 640];
image = imresize(image,imsize);
image = (image-min(image(:)))/(max(image(:))-min(image(:)));

tic

[saliencyCoord,saliencyMap,conspI,conspC,conspOr,CSI,RG,BY,orientationMaps,I,R,G,B,Y] = ittiSaliency(image);

time = toc

%% Figures

figure
imagesc(image)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'original image', 'NumberTitle', 'Off') 

figure
subplot(2,2,1)
imagesc(R)
title('R')
colorbar
subplot(2,2,2)
imagesc(G)
title('G')
colorbar
subplot(2,2,3)
imagesc(B)
title('B')
colorbar
subplot(2,2,4)
imagesc(Y)
title('Y')
colorbar
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'single color channels', 'NumberTitle', 'Off') 

figure
for i=1:6
subplot(2,3,i)
imagesc(CSI{i})
title(num2str(i))
colorbar
end
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'center surround of the gaussian pyramid of the intensity', 'NumberTitle', 'Off') 

figure
for i=1:6
subplot(2,3,i)
imagesc(RG{i})
title(num2str(i))
colorbar
end
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'RG center surround', 'NumberTitle', 'Off') 

figure
for i=1:6
subplot(2,3,i)
imagesc(BY{i})
title(num2str(i))
colorbar
end
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'BY center surround', 'NumberTitle', 'Off') 

for j=1:4
    figure
    for i=1:6
        subplot(2,3,i)
        imagesc(orientationMaps{j,i})
        title(num2str(i))
        colorbar
    end
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    set(gcf, 'Toolbar', 'none', 'Menu', 'none');
    set(gcf, 'Name', [num2str(j) 'th direction center surround'], 'NumberTitle', 'Off') 
end

figure
imagesc(conspI)
colorbar
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'conspiquity map of intensity', 'NumberTitle', 'Off') 

figure
imagesc(conspC)
colorbar
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'conspiquity map of colors', 'NumberTitle', 'Off') 

figure
imagesc(conspOr)
colorbar
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'conspiquity map of orientation', 'NumberTitle', 'Off') 

figure
imagesc(saliencyMap)
colorbar
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'overall itti salience', 'NumberTitle', 'Off') 

nOfSaliencies = size(saliencyCoord,2);
map = zeros(imsize);
for i=1:nOfSaliencies
    col = saliencyCoord{1,i}(1);
    row = saliencyCoord{1,i}(2);
    map(col,row) = 1/nOfSaliencies*(nOfSaliencies-i+1);
end
filtWindow = circFilter(min(imsize)/3);
map = conv2(map,filtWindow,'same');
map = map/max(map(:));

figure
imagesc(image)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'Focus of Attention points on image', 'NumberTitle', 'Off') 
hold on
imagesc(map,'alphaData',.5)
colormap turbo
colorbar