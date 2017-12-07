function val = img_source_galaxies(th_x, th_y)

th_min = [min(th_x(:)), min(th_y(:))];
th_max = [max(th_x(:)), max(th_y(:))];

% caluculate how many galaxies to draw
density = 0.002;
gcnt = size(th_x);
gcnt = ceil( density * gcnt(1) * gcnt(2) );

%gcnt = 0;

arcsec = pi / 180 / 3600;

% start with one galaxy close to the centre
siz = 0.5 + 0.5 * rand ^ 2;
Reff = ( 5.0 * siz * arcsec );
Ieff = siz;
rot = pi * rand;
e = get_rand_e();
n = 1 + abs(normrnd(3,1));
pol_ang = 2 * pi * rand;
pol_r = 0.5 * Reff * rand;
posx = pol_r * sin(pol_ang);
posy = pol_r * cos(pol_ang);
val = apply_galaxy(th_x, th_y, posx, posy, rot, e, Reff, Ieff, n);

% add more background galaxies
for i = 1:gcnt
    siz = 0.1 + 0.9 * rand ^ 2;
    Reff = ( 5.0 * siz * arcsec );
    Ieff = siz;
    
    g = random_galaxy(th_x, th_y, th_min, th_max, Reff, Ieff);
    val = val + g;
end

val = 0.02 * val;

end

% make a galaxy with a random position, rotation and ellipticity
function val = random_galaxy(th_x, th_y, th_min, th_max, Reff, Ieff)

pad = Reff * 1.0;
xmin = (th_min(1) - pad);
xmax = (th_max(1) + pad);
ymin = (th_min(2) - pad);
ymax = (th_max(2) + pad);
posx = xmin + (xmax - xmin) * rand;
posy = ymin + (ymax - ymin) * rand;

rot = pi * rand;
e = get_rand_e();

n = 1 + abs(normrnd(3,1));

val = apply_galaxy(th_x, th_y, posx, posy, rot, e, Reff, Ieff, n);

end

% I'm reusing the ellipticity distribution for the lensing galaxy here.
function e = get_rand_e()
    e = 0;
    while e < 0.1 || e >= 1.0
        e = normrnd(0.7, 0.3);
    end
end


