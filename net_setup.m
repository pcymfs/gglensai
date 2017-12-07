function net = net_setup(trainImg, trainVal)

imgSiz = size(trainImg,1);

disp('Preparing network structure...')
layers = [ ...
    imageInputLayer([imgSiz imgSiz 3])
    convolution2dLayer(11,25)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2) 
    convolution2dLayer(5,32,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2) 
    convolution2dLayer(3,64,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2) 
    convolution2dLayer(1,128,'Padding',1)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(18)
    fullyConnectedLayer(3)
    regressionLayer 
    ];

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.0004, 'MaxEpochs',4, ...
    'Verbose',true, 'Plots','training-progress');

disp('Beginning Training...')

net = trainNetwork(trainImg, trainVal, layers, options);

