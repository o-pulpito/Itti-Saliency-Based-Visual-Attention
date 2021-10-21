function filter = circFilter(d)
% filter = circFilter(d)
% Produces a circular filtering window of diameter d and weight that
% decreases from the center to the borders

% Code Author: Osvaldo Pulpito
% Email: osvaldopulpito@gmail.com
% Date: 19/10/2021

Y = repmat(1:d,d,1);
rho = sqrt((Y'-(d+1)/2).^2+(Y-(d+1)/2).^2)/((d+1)/2);
filter = (sin(pi/2*(1-rho).*(rho<=1))).^2;
filter = filter/sum(filter(:));
end