function fitness=jFitnessFunction(feat,label,X)
% % Parameter setting for k-value of KNN
% %k=5; %=5 
% % Parameter setting for number of cross-validation
% %kfold=5;
% % Error rate
% %fitness=jwrapperKNN(feat(:,X==1),label,k,kfold);
% net.output.processFcn={'mapminmax'}';
% net=feedforwardnet([15 5]);
% net.trainFcn='trainscg';
% % net.outputs{1}.transferFcn=
% % net.layers{1}.transforFcn='radbas';
% net.trainParam.lr=0.1;
% net.trainParam.max_fail=30;
% net.trainParam.epochs=5000;
% net=train(net,feat',label');
% y=net(feat');
% fitness = perform(net,label',y);

[mcord, mcovd, pValue, tStatistic, dof] = mcorrdis(label,feat(:,X==1));
fitness=mcord;
end

