function net_test(net, testImg, testVal)

disp('Testing...')

predictedVal = predict(net, testImg);

% prediction values
nRe  = predictedVal(:,1);
nQ   = predictedVal(:,2);
nRot = predictedVal(:,3);

% generation values
gRe  = testVal(:,1);
gQ   = testVal(:,2);
gRot = testVal(:,3);

% relative error
rErrRe  = (nRe - gRe)  ./ 1;
rErrQ   = (nQ - gQ)    ./ 1;
rErrRot = (nRot - gRot) / pi;

% standard deviation of relative error
stdRe  = std(rErrRe)
stdQ   = std(rErrQ)
stdRot = std(rErrRot)


qbinsiz = 1/10;
qbins = linspace(0,1-qbinsiz,1/qbinsiz);
stdVForQ = [];
for bin = qbins
    selectErrV = rErrRot(gQ >= bin & gQ < (bin + qbinsiz));
    stdVForQ(end+1) = std(selectErrV);
end

figure(1);
plot(qbins+qbinsiz/2, stdVForQ, '.-');
xlabel('Axes ratio')
ylabel('\sigma(\Delta \beta / \pi)')

%{
vlbs = ["R_e", "q", "rot"];
for i = 1:valcnt
    subplot(valcnt,1,i)
    histogram(relativeErr(:,i))
    title(sprintf('Rel.err. %s: %s=%f %s=%f',...
        vlbs(i), '\mu', M(i), '\sigma', S(i)));
end
%}
end
