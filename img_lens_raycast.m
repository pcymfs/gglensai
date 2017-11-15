% th_x, th_y: angular observation ray, relative to the lens centre
% m: mass
function val = img_lens_raycast(M, Dl, Ds, th_x, th_y, source)

% 4G/c^2
g4cc = 4 * (6.674e-11) / (3e8 ^ 2);

% a integral/sum of point masses should be done here
% for now I will consider only a single point mass, M

% square radial distance
th_rsq = th_x.^2 + th_y.^2;

% deflection angle
ax = (g4cc * M / th_rsq) * th_x;
ay = (g4cc * M / th_rsq) * th_y;

% get the unlensed observation position 
bx = th_x - ax * (Ds - Dl) / Ds;
by = th_y - ay * (Ds - Dl) / Ds;

% get the intensity at this position
val = source(bx, by);

end