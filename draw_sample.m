function draw_sample(imgs,vals)

disp('Drawing sample of training images...')

trainImgCnt = size(imgs,4);

figure
idx = randperm(trainImgCnt,20);
for i = 1:numel(idx)
    subplot(4,5,i)

    imshow(mat2gray(imgs(:,:,:,i)))
    title(sprintf('R_E = %f', vals(i)))
    drawnow
end

end

