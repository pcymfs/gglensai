function draw_sample(imgs,vals,net,i0)

disp('Drawing sample of images...')

if exist('net', 'var')
    predicted = predict(net, imgs);
end

if ~exist('i0', 'var')
    i0 = 0;
end

figure();
sx = 8;
sy = 3;

for y = 1:(sy)
    for x = 0:(sx-1)
        i = i0 + x * sy + y;
        subplot('Position',[x/sx (sy-y-0.1)/sy 1/sx 1/sy])

        imshow(mat2gray(imgs(:,:,:,i)));
        if exist('predicted', 'var')
            title(sprintf('R_E  I:%+.3f O:%+.3f\n q   I:%+.3f O:%+.3f \nrot I:%+.3f O:%+.3f', ...
                vals(i,1), predicted(i,1), ...
                vals(i,2), predicted(i,2), ...
                vals(i,3), predicted(i,3)), ...
                'FontName', 'FixedWidth');
        else
            title(sprintf('R_E  = %f\nq   = %f\nrot = %f', ... 
                vals(i,1), vals(i,2), vals(i,3)),'FontName', 'FixedWidth')
        end
    end
    drawnow
end

