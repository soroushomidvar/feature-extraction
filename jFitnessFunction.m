function fitness=jFitnessFunction(feat,label,selected)
X = feat{:,selected==1};
Y = label;
X = array2table(X);
Z = [X Y];

rng(5); % For reproducibility

% Set aside 90% of the data for training
cv = cvpartition(height(Z),'holdout',0.2);

t = RegressionTree.template('MinLeaf',5);

mdl = fitensemble(X(cv.training,:),Y(cv.training,:),'LSBoost',500,t,'LearnRate',0.01);

L = loss(mdl,X(cv.test,:),Y(cv.test),'mode','ensemble');
fprintf('Mean-square testing error = %f\n',L);
fitness = L;
end