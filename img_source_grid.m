% th_x, th_y: angular position vector
function val = img_source_grid(th_x, th_y)

% give the grid lines a broad lines
val = 0.5 * (grid_profile(th_x) + grid_profile(th_y));

end

function v = grid_profile(x)
v = sin(x * pi / 5) .^ 14;
end