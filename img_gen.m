% siz: side length of image in pixels
function img = img_gen(siz)

img = zeros(siz);

M = 1e29;
Dl = 1;
Ds = 4;
pix_angle = 1;

for x = 1:siz
    for y = 1:siz
        %
        img(x,y) = img_lens_raycast(...
            M, Dl, Ds, ...
            pix_angle * (x - 0.5 - siz/2),...
            pix_angle * (y - 0.5 - siz/2),...
            @img_source_grid);
        %}
        %{
        img(x,y) = img_source_grid(...
            pix_angle * (x - 0.5 - siz/2),...
            pix_angle * (y - 0.5 - siz/2));
        %}
    end
end

end
