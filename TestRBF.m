clc, clear, close
load mat/label.mat;
load mat/justNumber.mat;
feat=[justNumbercsv(:,1:394) justNumbercsv(:,397:418)];
label=table2array(lab(:,1));
feat=table2array(feat);

X=zeros(416);
positions= fix(416*rand(1,30))+1;
for j=1:30
    X(positions(j))=1;
end

feat=feat(:,X==1);


net.output.processFcn={'mapminmax'}';
net=feedforwardnet([15 5]);
net.trainFcn='trainscg';
% net.outputs{1}.transferFcn=
% net.layers{1}.transforFcn='radbas';
net.trainParam.lr=0.1;
net.trainParam.max_fail=100;
net.trainParam.epochs=10000;
net=train(net,feat',label');
y=net(feat');
perf = perform(net,label',y);














%
% % x=linspace(0,4*pi,3000);
% % y=(sin(x)+cos(x)+tanh(x))+rand(1,3000);
% %net=newrb(x,y,0.1,1,100,10);
% net=newrb(feat',label',0.1,1,50,5);
% view(net)
% results=sim(net,x);
% scatter(x,y);
% hold on;
% plot(x,results,'LineWidth',2,'MarkerSize',10)
% R=regression(y,results);