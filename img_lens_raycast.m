% th_x, th_y: angular observation ray, relative to the lens centre
% m: mass
function val = img_lens_raycast(Re, th_x, th_y, source)

% For a point mass, the lensing potential is Re^2*ln(r)
% so deflection = grad potential = Re^2/r => Re^2 * (x,y)/r^2

% radial distance
th_rsq = th_x.^2 + th_y.^2;

% get the unlensed observation position 
bx = th_x - (Re * Re ./ th_rsq) .* th_x;
by = th_y - (Re * Re ./ th_rsq) .* th_y;

% get the intensity at this position
val = source(bx, by);

end