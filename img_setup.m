function [imgs, vals] = img_setup(n, seed)

imgSiz = 64;

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

    e = get_rand_e();
    Re = get_rand_Re();
    rot = pi * (rand - 0.5);
    img = img_gen(imgSiz, Re, e, rot);
    imgs(:,:,1,i) = img;
    imgs(:,:,2,i) = imgaborfilt(img, 3, 0);
    imgs(:,:,3,i) = imgaborfilt(img, 3, 90);
    
    vals(i,1) = Re;
    vals(i,2) = e;
    vals(i,3) = rot;
end

end

function e = get_rand_e()
    % e follows a Rayleigh distribution with B = 0.3, truncated at 0.2
    % T. E. Collett (2015)
    e = 0;
    while e < 0.2 || e >= 1.0
        e = raylrnd(0.3);
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


