function [imgs, vals] = img_setup(n)

imgSiz = 64;

imgs = zeros(imgSiz, imgSiz, 1, n);
vals = zeros(1,1,1,n);

disp('Generating images...')
for i = 1:n
    if mod(i, 100) == 0
        fprintf('Images generated: %d\n', i)
    end
    
    Re = abs(normrnd(12,6));
    imgs(:,:,1,i) = img_gen(imgSiz, Re);
    vals(:,:,:,i) = Re;
end

end

