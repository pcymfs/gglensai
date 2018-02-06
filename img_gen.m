function img = img_gen(siz, MRe, Mq, Mrot, LReff, Lq, Lrot, LIeff, Ln, zl, zs)
% generates an image for the specified parameters
% siz   : side length of image in pixels
% MRe   : mass profile, eistein radius in arcseconds
% Mq    : mass profile, lens axes ratio
% Mrot  : mass profile, lens rotation
% LReff : light profile, effective radius
% Lq    : light profile, galaxy axes ratio
% Lrot  : light profile, rotation
% LIeff : effective intensity (at LReff)
% Ln    : Sersic index
% zl    : redshift of lens
% zs    : redshift of source


pix_angle = 0.18; % LSST:0.18, EUCLID:0.1
arcsec = pi / 180 / 3600;

[X, Y] = meshgrid(...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz), ...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz));


[xrot,yrot] = rotate(X, Y, Mrot);

% raycast the source image through the lens
img = img_lens_raycast('IsothermalEllipsoid', ...
    MRe * arcsec, Mq, xrot, yrot, @img_source_galaxies);

% {
% get the lensing galaxy in the image foreground
[xrot,yrot] = rotate(X, Y, Lrot);
lgx = apply_galaxy(xrot, yrot, 0, 0, 0, Lq, LReff, LIeff, Ln);

% put the colour channels together
%img = cat(3, lgx, zeros(size(img)), img);
img = img + lgx;
%}

% apply discrete pixlation
img = floor(256 * img) / 256;
img(img > 1) = 1;

end

function [xrot,yrot] = rotate(X, Y, rot)
% rotate the coordinate system about 0,0
xy = [(X(:)') ; (Y(:)')];
vrot = [cos(rot) -sin(rot); sin(rot) cos(rot)] * xy;

xrot = vrot(1,:);
yrot = vrot(2,:);
xrot = reshape(xrot, size(X));
yrot = reshape(yrot, size(Y));

end

