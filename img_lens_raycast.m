% th_x, th_y: angular observation ray, relative to the lens centre
% Re        : Einstein radius (arc sec)
% q         : ellipticity
function val = img_lens_raycast(model, Re, q, th_x, th_y, source)

if strcmp(model, 'Source')
    bx = th_x;
    by = th_y;
    
elseif strcmp(model, 'PointMass')
    % lensing potential: Re^2*ln(r)
    % => deflection = Re^2/r = Re^2 * (x,y)/r^2

    % radial distance
    th_rsq = th_x.^2 + th_y.^2;

    % get the unlensed observation position 
    bx = th_x - (Re * Re ./ th_rsq) .* th_x;
    by = th_y - (Re * Re ./ th_rsq) .* th_y;

elseif strcmp(model, 'IsothermalEllipsoid')
    s = 0;
    
    sqq = q*q;
    rtq = sqrt(1 - sqq);
    c = Re * q / rtq;
    psi = sqrt(sqq * (s*s + th_x.*th_x) + th_y.*th_y);
    
    ax = c * atan2(rtq * th_x, psi + s);
    ay = c * atanh((rtq * th_y) ./ (psi + sqq*s));
    
    bx = th_x - real(ax);
    by = th_y - real(ay);
    
else 
    disp(strcat('Unknown model: ', model))
    disp('Defaulting to source image.')
    bx = th_x;
    by = th_y;
end

% get the intensity at this position
val = source(bx, by);

end