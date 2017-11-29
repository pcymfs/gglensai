function img = img_gen(siz, Re, e, rot)
% generates an image of a lensed background
% siz: side length of image in pixels
% Re : eistein radius in arcseconds
% e  : lens ellipticity

pix_angle = 0.18; % LSST:0.18, EUCLID:0.1
arcsec = pi / 180 / 3600;

[X, Y] = meshgrid(...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz), ...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz));

% rotate the coordinate system about 0,0
v = [(X(:)') ; (Y(:)')];
Mrot = [cos(rot) -sin(rot); sin(rot) cos(rot)];

vrot = Mrot * v;

xrot = vrot(1,:);
yrot = vrot(2,:);
xrot = reshape(xrot, size(X));
yrot = reshape(yrot, size(Y));


img = img_lens_raycast('IsothermalEllipsoid', ...
    Re * arcsec, e, xrot, yrot, @img_source_galaxies);

% {
% add the lensing galaxy to the image foreground
siz = 0.5 + 0.5 * rand ^ 2;
Reff = siz * Re * arcsec;
Ieff = siz * Re;
n = 1 + abs(normrnd(3,1));
lgx = apply_galaxy(xrot, yrot, 0, 0, 0, e, Reff, Ieff, n);

img = (img + 0.2 * lgx);
%}

% apply gray scale
img = floor(256 * img) / 256;
img(img > 1) = 1;

end
