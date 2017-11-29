function img = img_gen(siz, Re, e)
% generates an image of a lensed background
% siz: side length of image in pixels
% Re : eistein radius in arcseconds
% e  : lens ellipticity

pix_angle = 0.15;
arcsec = pi / 180 / 3600;

[X, Y] = meshgrid(...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz), ...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz));

img = img_lens_raycast('IsothermalEllipsoid', ...
    Re * arcsec, e, X, Y, @img_source_galaxies);

% apply gray scale
img = floor(256 * img) / 256;
img(img > 1) = 1;

end
