function net_test(net, testImg, testVal)

disp('Testing...')

predictedVal = predict(net, testImg);
[predictedVal(1:40,:), testVal(1:40,:)]
relativeErr = (predictedVal - testVal) ./ testVal;

M = mean(relativeErr);
S = std(relativeErr);
valcnt = size(testVal,2);
vlbs = ["R_e", "e"];
for i = 1:valcnt
    subplot(valcnt,1,i)
    histogram(relativeErr(:,i))
    title(sprintf('Rel.err. %s: %s=%f %s=%f',...
        vlbs(i), '\mu', M(i), '\sigma', S(i)));
end

end
