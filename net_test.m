function net_test(net, testImg, testVal)

disp('Testing...')

predictedVal = predict(net, testImg);
[predictedVal(1:100), testVal(1:100)]
predictionError = reshape(testVal, 1, []) - reshape(predictedVal, 1, []);

histogram(predictionError);

end
