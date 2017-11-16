imgSiz = 64;

trainImgCnt = 100;
trainImg = zeros(imgSiz, imgSiz, 1, trainImgCnt);
trainVal = zeros(1,1,1,trainImgCnt);

disp('Generating images...')
for i = 1:trainImgCnt
    Re = rand() * imgSiz * 0.3 + 6;
    trainImg(:,:,1,i) = img_gen(imgSiz, Re);
    trainVal(:,:,:,i) = Re;
end

disp('Preparing network structure...')
layers = [ ...
    imageInputLayer([imgSiz imgSiz 1])
    convolution2dLayer(12,96, 'Stride', 4)
    reluLayer
    fullyConnectedLayer(1)
    regressionLayer];

options = trainingOptions('sgdm','InitialLearnRate',0.01, ...
    'MaxEpochs',5);

disp('Beginning Training...')
net = trainNetwork(trainImg,trainVal,layers,options);

disp('Testing...')
testImgCnt = 200;
testImg = zeros(imgSiz, imgSiz, 1, testImgCnt);
testVal = zeros(testImgCnt,1,1,1);

disp('Generating test images...')
for i = 1:testImgCnt
    Re = rand() * imgSiz * 0.3 + 6;
    testImg(:,:,1,i) = img_gen(imgSiz, Re);
    testVal(i,:,:,:) = Re;
end


predictedVal = predict(net, testImg);

predictionError = testVal - predictedVal;

thr = 10;
numCorrect = sum(abs(predictionError) < thr);
numTestImages = size(testImg,4);

accuracy = numCorrect / testImgCnt
