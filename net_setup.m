imgSiz = 96;

trainImgCnt = 700;
trainImg = zeros(imgSiz, imgSiz, 1, trainImgCnt);
trainVal = zeros(1,1,1,trainImgCnt);

disp('Generating images...')
for i = 1:trainImgCnt
    Re = rand() * imgSiz * 0.3 + 6;
    trainImg(:,:,1,i) = img_gen(imgSiz, Re);
    trainVal(:,:,:,i) = Re;
end

figure
idx = randperm(trainImgCnt,20);
for i = 1:numel(idx)
    subplot(4,5,i)

    imshow(mat2gray(trainImg(:,:,:,i)))
    title(sprintf('R_E = %f', trainVal(:,:,:,i)))
    drawnow
end

disp('Preparing network structure...')
layers = [ ...
    imageInputLayer([imgSiz imgSiz 1])
    convolution2dLayer(12,96, 'Stride', 8)
    reluLayer
    fullyConnectedLayer(1)
    regressionLayer];

options = trainingOptions('sgdm','InitialLearnRate',0.005, 'MaxEpochs',30, 'Verbose', true);

disp('Beginning Training...')
net = trainNetwork(trainImg,trainVal,layers,options);

disp('Testing...')
testImgCnt = 1000;
testImg = zeros(imgSiz, imgSiz, 1, testImgCnt);
testVal = zeros(1,1,1,trainImgCnt);

disp('Generating test images...')
for i = 1:testImgCnt
    Re = rand() * imgSiz * 0.3 + 6;
    testImg(:,:,1,i) = img_gen(imgSiz, Re);
    testVal(:,:,:,i) = Re;
end


predictedVal = predict(net, testImg);

predictionError = reshape(testVal, 1, []) - reshape(predictedVal, 1, []);

numCorrect = sum(abs(predictionError) < 2);
accuracy = numCorrect / size(testImg,4)


