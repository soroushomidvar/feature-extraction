clc, clear, close 
load label.mat;
load justNumber.mat;
% Call features & labels
feat_table=[justNumbercsv(:,1:394) justNumbercsv(:,397:418)]; % remove labels from dataset: TOTALBTU,TOTALDOL 
feat=table2array(feat_table); 
label_table=lab(:,1);
label=table2array(lab(:,1)); 
%kmeans
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
close all; N=14; T=20; CR=0.8; MR=0.01; 
[sFeat,Sf,Nf,curve]=jGA(feat_table,label_table,N,T,CR,MR);

% Plot convergence curve
figure(); plot(1:T,curve); xlabel('Number of Iterations');
ylabel('Fitness Value'); title('GA'); grid on;
% 
% %% (Method 2) GA version 2 
% % Assume the chromosomes with CR probabilities are used in selection process 
% close all; N=10; T=10; CR=0.8; MR=0.01; 
% [sFeat,Sf,Nf,curve]=jGA2(feat,label,N,T,CR,MR);
% 
% % Plot convergence curve
% figure(); plot(1:T,curve); xlabel('Number of Iterations');
% ylabel('Fitness Value'); title('GA2'); grid on;

%--------------------------------------------
%Result
findFeatures(feat_table,Sf)


function y= findFeatures(feat_table,Sf)
a=[
find(strcmpi(feat.Properties.VariableNames,'WASHLOAD'))
find(strcmpi(feat.Properties.VariableNames,'DRYRUSE'))
find(strcmpi(feat.Properties.VariableNames,'LGTOUTNUM'))
find(strcmpi(feat.Properties.VariableNames,'TOTALBTUSPH'))
find(strcmpi(feat.Properties.VariableNames,'DOLELAHUHEAT'))
find(strcmpi(feat.Properties.VariableNames,'TOTALDOLSPH'))
find(strcmpi(feat.Properties.VariableNames,'SOLAR'))
find(strcmpi(feat.Properties.VariableNames,'TOTROOMS'))
find(strcmpi(feat.Properties.VariableNames,'WINDOWS'))
find(strcmpi(feat.Properties.VariableNames,'MONEYPY'))
];
y = ismember(a',Sf);
end

