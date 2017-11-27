function [imgs, vals] = img_setup(n)

imgSiz = 64;

imgs = zeros(imgSiz, imgSiz, 1, n);
vals = zeros(n,1);

disp('Generating images...')
for i = 1:n
    if mod(i, 100) == 0
        fprintf('Images generated: %d\n', i)
    end
    
    Re = abs(normrnd(1.2,0.6));
    imgs(:,:,1,i) = img_gen(imgSiz, Re);
    vals(i,1) = Re;
end

end

