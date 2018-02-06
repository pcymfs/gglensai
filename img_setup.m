function [imgs, vals] = img_setup(n, seed)

    imgSiz = 64;
    arcsec = pi / 180 / 3600;

    if exist('seed', 'var')
        rng(seed);
    end

    imgs = zeros(imgSiz, imgSiz, 1, n);
    vals = zeros(n,1);


    % Ininitalize a numerical probability density function for the redshift
    % (consider redshift to be independent of lens size and ellipticity)

    %gaussian = @(x) (1/sqrt((2*pi))*exp(-x.^2/2));
    skewedgaussian = @(x,alpha) 2*((1/sqrt((2*pi))*exp(-x.^2/2))).*normcdf(alpha*x);

    % approximate skewed gaussian found using cftool, fitting to 57 data points 
    % taken from https://www.cfa.harvard.edu/castles

    function zl = get_rand_zlens()

        zlens_prob = @(zlens) skewedgaussian(2.2*zlens-0.5, 2.5);
        
        % get a random number in this probability distribution
        zl = rand() * 2;
        while rand() > zlens_prob(zl)
            zl = rand() * 2;
        end
    end

    function zs = get_rand_zsource(zl)

        zsource_prob = @(zsourc) skewedgaussian(0.63*zsourc-0.64, 2.2);
        
        zs = zl*1.5 + rand() * 5;
        while rand() > zsource_prob(zs)
            zs = zl*1.5 + rand() * 5;
        end
    end

    %{
    v = zeros(1000,1);
    for i = 1:1000
        v(i) = get_rand_zsource(get_rand_zlens());
    end
    histogram(v)
    %}
    %



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
        %LReff = (0.2  + abs(normrnd(0.8, 0.25))) * MRe * arcsec;
        LReff = (0.4  + abs(normrnd(0.6, 0.15))) * MRe * arcsec;
        
        % Shear can cause the luminous ellipticity to differ significantly from
        % the lens mass distribution. Otherwise it should be closely related.
        % Koopmans et al. 2006
        Lq = Mq * (0.5 + abs(normrnd(0.5, 0.1)));

        % The rotation of the light profile is a function of the lens rotation
        % and the ellipticity. I designed a probability distribution that is 
        % very simple but objectively matches the samples in R. Gavazzi, 2012.
        Lrot = mod(Mrot + normrnd(0, 0.1 * pi * Mq), pi); 


        Ieff = (0.03 + abs(normrnd(0.1, 0.01))) * LReff / arcsec;
        n = 1 + abs(normrnd(3,1));

        img = img_gen(imgSiz, MRe, Mq, Mrot, LReff, Lq, Lrot, Ieff, n);
        imgs(:,:,1,i) = img;

        vals(i,1) = MRe;
        vals(i,2) = Mq;
        vals(i,3) = Mrot;
    end

end

function q = get_rand_q()
    % A function for the axes ratio distibution I came up with, based on
    % the samples in equation 
    q = 0;
    while q < 0.1 || q >= 1.0
        %q = normrnd(0.7, 0.3);
        % Use a uniform distribution for the error analysis testing
        q = 0.1 + rand() * 0.9;
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


