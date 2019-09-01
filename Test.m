clc, clear, close 
load label.mat;
load justNumber.mat;
feat_table=[justNumbercsv(:,1:394) justNumbercsv(:,397:418)]; % remove labels from dataset: TOTALBTU,TOTALDOL 
feat=table2array(feat_table); 
label_table=lab(:,1);

z=zeros(416);
positions=fix(416*rand(1,30))+1;
for j=1:30
    z(positions(j))=1;
end
feat_table=feat_table(:,z==1);


Y = label_table;
X = feat_table;
Z = [X Y];

rng(5); % For reproducibility

% Set aside 80% of the data for training
cv = cvpartition(height(Z),'holdout',0.2);

t = RegressionTree.template('MinLeaf',5);

mdl = fitensemble(X(cv.training,:),Y(cv.training,:),'LSBoost',500,t,'LearnRate',0.01);

L = loss(mdl,X(cv.test,:),Y(cv.test),'mode','ensemble');
fprintf('Mean-square testing error = %f\n',L);
fitness = L;
