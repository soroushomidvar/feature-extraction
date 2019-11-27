
clc, clear, close 
% Benchmark data set contains 351 instances and 34 features (binary class)
%load first.mat; % Matlab also provides this dataset (load Ionosphere.mat)
load mat/label.mat;
load mat/justNumber.mat;
% zzz=zeros(5600,1);
% ooo=ones(86,1);
% fff=[zzz;ooo];
% Call features & labels
%feat=myDataForDataMiningwithoutFlagcsv(:,5:100);
feat=[justNumbercsv(:,1:394) justNumbercsv(:,397:418)]; % remove labels from dataset: TOTALBTU ,TOTALDOL %Label: TOTALBTU

feat_table=feat;
feat=table2array(feat);

%kmeans
label=table2array(lab(:,1)); 
%label_min=round(min(table2array(lab(:,1))));
%label_max=round(max(table2array(lab(:,1))));
%bins = label_min:10000:label_max;

%label_after_kmeans= kmeans(label,3);
%label=label_after_kmeans;
%

%label=fff;
%---Input------------------------------------------------------------------
% feat:  feature vector (instances x features)
% label: labelling
% N:     Number of chromosomes
% T:     Maximum number of generations
% CR:    Crossover rate
% MR:    Mutation rate
% *Note: k-value of KNN & k-fold setting can be modified in jFitnessFunction.m
%---Output-----------------------------------------------------------------
% sFeat: Selected features (instances x features)
% Sf:    Selected feature index
% Nf:    Number of selected features
% curve: Convergence curve
%--------------------------------------------------------------------------

%% (Method 1) GA  


%--------------------------------------------
%[R2sFeat,R2Sf,R2Nf,R2curve]=jGA(feat(:,Sf),label,N,T,CR,MR);
%find(strcmpi(feat.Properties.VariableNames,'XXXXXXXXX'))
%--------------------------------------------


%[mcord, mcovd, pValue, tStatistic, dof] = mcorrdis(label,feat);



% close all; N=10; T=3; CR=0.8; MR=0.01; numberOfFetures=30;
% [sFeat,Sf,Nf,curve]=jGA(feat,label,N,T,CR,MR,numberOfFetures);

% Plot convergence curve
%figure(); plot(1:T,curve); xlabel('Number of Iterations');
%label('Fitness Value'); title('GA'); grid on;
% 
% %% (Method 2) GA version 2 
% % Assume the chromosomes with CR probabilities are used in selection process 
 close all; N=150; T=25; CR=0.8; MR=0.01; 
 [sFeat,Sf,Nf,curve]=jGA2(feat,label,N,T,CR,MR);
% 
% % Plot convergence curve
 figure(); plot(1:T,curve); xlabel('Number of Iterations');
 ylabel('Fitness Value'); title('GA2'); grid on;

%--------------------------------------------
%Result
findFeatures(feat_table,Sf)


