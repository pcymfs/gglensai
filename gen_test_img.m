
% Test using:
% https://uk.mathworks.com/help/nnet/examples/training-a-deep-neural-network-for-digit-classification.html

function [imgs,out] = gen_test_img(n, siz)
    imgs = [];
    out = [];
    pnts = 20;
    sigm = 1;
    
    % generate a list of images that are just discrete gaussian patches at
    % random positions
    for i = 1:n
        img = zeros(siz,siz);
        
        centx = randi(siz);
        centy = randi(siz);
        
        for j = 1:pnts
            x = ceil(normrnd(centx, sigm));
            if x < 1 || x > siz
                continue
            end
            y = ceil(normrnd(centy, sigm));
            if y < 1 || y > siz
                continue
            end
            img(x,y) = 1;
        end
            
        imgs = cat(3, imgs, img);
        out = cat(3, out, [centx, centy]);
    end
end

