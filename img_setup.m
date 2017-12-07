function [imgs, vals] = img_setup(n, seed)

imgSiz = 64;
arcsec = pi / 180 / 3600;

if exist('seed', 'var')
    rng(seed);
end
    
imgs = zeros(imgSiz, imgSiz, 3, n);
vals = zeros(n,3);

disp('Generating images...')
for i = 1:n
    if mod(i, 100) == 0
        fprintf('Images generated: %d\n', i)
    end

    % Get some initial values for the mass profile
    Mq = get_rand_q();
    MRe = get_rand_Re();
    Mrot = pi * rand;
    
    % The relation between Reff and Re is not quite clear from the sample
    % in R. Gavazzi, 2012; due to its small sample. But a reasonable fit
    % can be made with a (positive) random multiplication factor.
    LReff = (0.2  + abs(normrnd(0.8, 0.25))) * MRe * arcsec;
    
    % Shear can cause the luminous ellipticity to differ significantly from
    % the lens mass distribution. Otherwise it should be closely related.
    % Koopmans et al. 2006
    Lq = Mq * (0.5 + abs(normrnd(0.5, 0.1)));
    
    % The rotation of the light profile is a function of the lens rotation
    % and the ellipticity. I designed a probability distribution that is 
    % very simple but objectively matches the samples in R. Gavazzi, 2012.
    Lrot = mod(Mrot + normrnd(0, 0.1 * pi * Mq), pi); 
    
    
    Ieff = (0.05 + abs(normrnd(0.1, 0.01))) * LReff / arcsec;
    n = 1 + abs(normrnd(3,1));
    
    img = img_gen(imgSiz, MRe, Mq, Mrot, LReff, Lq, Lrot, Ieff, n);
    imgs(:,:,:,i) = img;
    
    vals(i,1) = MRe;
    vals(i,2) = Mq;
    vals(i,3) = Mrot;
end

end

function e = get_rand_q()
    % A function for the ellipticity distibution I came up with, based on
    % the samples in equation 
    e = 0;
    while e < 0.1 || e >= 1.0
        e = normrnd(0.7, 0.3);
    end
end

function Re = get_rand_Re()
    % T. E. Collett (2015)
    % Abusing the effective radius formula for the eistein radius.
    % I made up values for Mv and z to fit the distribution.
    Mv = -1.8;
    z = 0.5;
    
    Re = (Mv/-19.5)^-.22 * ((1+z)/5)^-1.2 + normrnd(0, 0.3);
    Re = exp(Re) / 1000;
end


