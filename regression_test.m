[trainImages,~,trainAngles] = digitTrain4DArrayData;

layers = [ ...
    imageInputLayer([28 28 1])
    convolution2dLayer(12,25)
    reluLayer
    fullyConnectedLayer(1)
    regressionLayer];

options = trainingOptions('sgdm','InitialLearnRate',0.001, ...
    'MaxEpochs',15, 'Plots','training-progress');


net = trainNetwork(trainImages,trainAngles,layers,options)

[testImages,~,testAngles] = digitTest4DArrayData;

predictedTestAngles = predict(net,testImages);

predictionError = testAngles - predictedTestAngles;

thr = 10;
numCorrect = sum(abs(predictionError) < thr);
numTestImages = size(testImages,4);

accuracy = numCorrect/numTestImages