% th_x, th_y: angular position vector
function val = img_source_grid(th_gridspacing, th_x, th_y)

% give the grid lines a broad lines
val = grid_profile(th_x / (th_gridspacing));
val = val + grid_profile(th_y / (th_gridspacing));
val = 0.5 * val;

end


function v = grid_profile(x)
v = sin(x * pi) ^ 10;
end