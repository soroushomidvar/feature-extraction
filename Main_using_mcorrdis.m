clc, clear, close
% Benchmark data set contains 351 instances and 34 features (binary class)
%load first.mat; % Matlab also provides this dataset (load Ionosphere.mat)
load label.mat;
load justNumber.mat;
feat=[justNumbercsv(:,1:394) justNumbercsv(:,397:418)]; % remove labels from dataset: TOTALBTU,TOTALDOL
feat_table=feat;
feat=table2array(feat);
label=table2array(lab(:,1));
%normalizedFeatures= NormalizeFunction(feat);
normalized_features= Normalize(feat);
%normalized_label=Normalize(label);

mcord_normalized_features=zeros(5,size(normalized_features,2));
for i = 1:size(normalized_features,2)
    [mcord, mcovd, pValue, tStatistic, dof] = mcorrdis(normalized_features(:,i),normalized_label);
    mcord_normalized_features(1,i)=mcord;
    mcord_normalized_features(2,i)=mcovd;
    mcord_normalized_features(3,i)=pValue;
    mcord_normalized_features(4,i)=tStatistic;
    mcord_normalized_features(5,i)=dof;
end

mcord_normalized_features_table=array2table(mcord_normalized_features);
mcord_normalized_features_table.Properties.VariableNames=feat_table.Properties.VariableNames;
out = sort_table(mcord_normalized_features_table,1);

writetable(out,'out.csv') 

