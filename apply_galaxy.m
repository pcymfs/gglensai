% draw a galaxy with the given parameters
function val = apply_galaxy(th_x, th_y, posx, posy, rot, q, Reff, Ieff, n)

v = [(th_x(:)'-posx) ; (th_y(:)'-posy)];
Mrot = [cos(rot) -sin(rot); sin(rot) cos(rot)];

vrot = Mrot * v;

xrot = vrot(1,:);
yrot = vrot(2,:);

R = sqrt(xrot.^2 + yrot.^2/q^2);

val = sersic(Ieff, R, Reff, n);
val = reshape(val, size(th_x));

end

function val = sersic(Ieff, R, Reff, n)

kn = 1.9992*n - 0.3271;
val = Ieff * exp( -kn * ((R./Reff).^(1/n) - 1) );

end

