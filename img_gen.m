function img = img_gen(siz)

img = zeros(siz);
pix_angle = 1;

for x = 1:siz
    for y = 1:siz
        img(x,y) = test_source_grid(...
            pix_angle * 5,... 
            pix_angle * (x - 0.5 - siz/2),...
            pix_angle * (y - 0.5 - siz/2));
    end
end

end
