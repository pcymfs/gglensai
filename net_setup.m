function net = net_setup(trainImg, trainVal)

imgSiz = size(trainImg,1);

disp('Preparing network structure...')
layers = [ ...
    imageInputLayer([imgSiz imgSiz 1])
    convolution2dLayer(18,96, 'Stride', 12)
    reluLayer
    fullyConnectedLayer(1)
    regressionLayer]

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.005, 'MaxEpochs',12, ...
    'Verbose',true, 'Plots','training-progress');

disp('Beginning Training...')

net = trainNetwork(trainImg, trainVal, layers, options);

