[trainImages,~,trainAngles] = digitTrain4DArrayData;

numTrainImages = size(trainImages,4);

figure
idx = randperm(numTrainImages,20);
for i = 1:numel(idx)
    subplot(4,5,i)

    imshow(trainImages(:,:,:,idx(i)))
    drawnow
end

layers = [ ...
    imageInputLayer([28 28 1])
    convolution2dLayer(12,25)
    reluLayer
    fullyConnectedLayer(1)
    regressionLayer];

options = trainingOptions('sgdm','InitialLearnRate',0.001, ...
    'MaxEpochs',50);

net = trainNetwork(trainImages,trainAngles,layers,options);

net.Layers

[testImages,~,testAngles] = digitTest4DArrayData;

predictedTestAngles = predict(net,testImages);

predictionError = testAngles - predictedTestAngles;

thr = 10;
numCorrect = sum(abs(predictionError) < thr);
numTestImages = size(testImages,4);

accuracy = numCorrect/numTestImages

squares = predictionError.^2;
rmse = sqrt(mean(squares))

residuals = testAngles - predictedTestAngles;

residualMatrix = reshape(residuals,500,10);

figure
boxplot(residualMatrix, ...
    'Labels',{'0','1','2','3','4','5','6','7','8','9'})

xlabel('Digit Class')
ylabel('Degrees Error')
title('Residuals')

idx = randperm(numTestImages,49);
for i = 1:numel(idx)
    image = testImages(:,:,:,idx(i));
    predictedAngle = predictedTestAngles(idx(i));

    imagesRotated(:,:,:,i) = imrotate(image,predictedAngle,'bicubic','crop');
end

figure
subplot(1,2,1)
montage(testImages(:,:,:,idx))
title('Original')

subplot(1,2,2)
montage(imagesRotated)
title('Corrected')