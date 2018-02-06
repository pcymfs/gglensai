function net = net_setup(trainImg, trainVal)

imgSiz = size(trainImg,1);

disp('Preparing network structure...')
layers = [ ...
    imageInputLayer([imgSiz imgSiz 1])
    convolution2dLayer(7,32)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',2) 
    convolution2dLayer(5,128)
    reluLayer
    maxPooling2dLayer(3,'Stride',2) 
    convolution2dLayer(1,128)
    reluLayer
    convolution2dLayer(3,256)
    reluLayer
    convolution2dLayer(3,128)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(225)
    fullyConnectedLayer(6400)
    fullyConnectedLayer(6400)
    fullyConnectedLayer(3)
    regressionLayer 
    ]



options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, 'MaxEpochs',1, 'MiniBatchSize',12, ...
    'Verbose',true, 'Plots','training-progress');

disp('Beginning Training...')

net = trainNetwork(trainImg, trainVal, layers, options);

