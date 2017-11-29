function val = img_source_galaxies(th_x, th_y)

th_min = [min(th_x(:)), min(th_y(:))];
th_max = [max(th_x(:)), max(th_y(:))];

% caluculate how many galaxies to draw
density = 0.001;
gcnt = size(th_x);
gcnt = ceil( density * gcnt(1) * gcnt(2) );

%gcnt = 0;

scale = 0.00002;

% start with a galaxy close to the centre
siz = 0.4 + 0.6 * rand ^ 2;
Reff = ( scale * siz );
Ieff = siz;
val = random_galaxy(th_x, th_y, [0,0], [0,0], Reff, Ieff);

% add more galaxies
for i = 1:gcnt
    siz = 0.1 + 0.9 * rand ^ 2;
    Reff = ( scale * siz );
    Ieff = siz;
    
    g = random_galaxy(th_x, th_y, th_min, th_max, Reff, Ieff);
    val = val + g;
end

val = 0.0175 * val;

end

% make a galaxy with a random position, rotation and ellipticity
function val = random_galaxy(th_x, th_y, th_min, th_max, Reff, Ieff)

pad = Reff * 0.5;
xmin = (th_min(1) - pad);
xmax = (th_max(1) + pad);
ymin = (th_min(2) - pad);
ymax = (th_max(2) + pad);
posx = xmin + (xmax - xmin) * rand;
posy = ymin + (ymax - ymin) * rand;

rot = pi * rand;
e = 0.1 + 0.8999 * rand^0.5;

n = abs(normrnd(4,1));

val = apply_galaxy(th_x, th_y, posx, posy, rot, e, Reff, Ieff, n);

end

% draw a galaxy with the given parameters
function val = apply_galaxy(th_x, th_y, posx, posy, rot, e, Reff, Ieff, n)

v = [(th_x(:)'-posx) ; (th_y(:)'-posy)];
Mrot = [cos(rot) -sin(rot); sin(rot) cos(rot)];

vrot = Mrot * v;

xrot = vrot(1,:);
yrot = vrot(2,:);

R = sqrt(xrot.^2 + yrot.^2/e);

val = sersic(Ieff, R, Reff, n);
val = reshape(val, size(th_x));

end

function val = sersic(Ieff, R, Reff, n)

kn = 1.9992*n - 0.3271;
val = Ieff * exp( -kn * ((R./Reff).^(1/n) - 1) );

end