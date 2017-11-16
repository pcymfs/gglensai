% th_x, th_y: angular position vector
function val = img_source_grid(th_x, th_y)

arcsec = pi / 180 / 3600;

% give the grid lines a broad lines
val = 0.5 * (grid_profile(th_x / arcsec) + grid_profile(th_y / arcsec));

end

function v = grid_profile(x)
v = cos(x * pi / 6) .^ 16;
end