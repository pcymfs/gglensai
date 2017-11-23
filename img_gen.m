% siz: side length of image in pixels
% Re : eistein radius in arcseconds
function img = img_gen(siz, Re)

pix_angle = 1;
arcsec = pi / 180 / 3600;

[X, Y] = meshgrid(...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz), ...
    pix_angle * arcsec * linspace(-siz/2, siz/2, siz));

img = img_lens_raycast('IsothermalEllipsoid', ...
    Re * arcsec, .4, X, Y, @img_source_galaxies);

% apply gray scale
img = floor(256 * img) / 256;
img(img > 1) = 1;

end
