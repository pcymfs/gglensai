% th_x, th_y: angular position vector
function val = img_source_demo(th_x, th_y)

arcsec = pi / 180 / 3600;

%{
% give the grid lines a smooth thinkness
val = 0.5 * (grid_profile(th_x / arcsec) + grid_profile(th_y / arcsec));

% draw some circles at different distances
val(((th_x/arcsec + 90).^2 + (th_y/arcsec + 90).^2) < 16) = 1;

val(((th_x/arcsec + 30).^2 + (th_y/arcsec + 30).^2) < 16) = 1;

val(((th_x/arcsec + 10).^2 + (th_y/arcsec + 10).^2) < 16) = 1;
%}

cmap = jet(100);

val = ind2rgb(50+floor(th_x/arcsec),cmap) .* (1 - grid_profile(th_x/arcsec));

end

function v = grid_profile(x)
v = cos(x * pi / 6) .^ 32;
%v(x < 0) = 0;
end