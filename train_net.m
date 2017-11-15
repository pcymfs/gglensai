

options = trainingOptions('sgdm', 'MaxEpochs',10, 'Verbose',true, ...
    'ExecutionEnvironment', 'gpu',...
    'ValidationData',valDigitData,...
    'ValidationFrequency',30,...
    'Plots','training-progress')

tic
net = trainNetwork(trainDigitData,layers,options);
fprintf('Time: %f', toc)


predictedLabels = classify(net,valDigitData);
valLabels = valDigitData.Labels;

accuracy = sum(predictedLabels == valLabels)/numel(valLabels)








