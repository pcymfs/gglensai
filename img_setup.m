function [imgs, vals] = img_setup(n)

imgSiz = 64;

imgs = zeros(imgSiz, imgSiz, 1, n);
vals = zeros(n,2);

disp('Generating images...')
for i = 1:n
    if mod(i, 100) == 0
        fprintf('Images generated: %d\n', i)
    end
    
    Re = 0.4 + abs(normrnd(1.0,0.5));
    e  = rand * 0.8 + 0.2;
    imgs(:,:,1,i) = img_gen(imgSiz, Re, e);
    vals(i,1) = Re;
    vals(i,2) = e;
end

end

