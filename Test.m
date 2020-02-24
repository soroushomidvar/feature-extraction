clc, clear, close
%   load .mat files
load mat/label.mat;
load mat/feat_with_NaN.mat
load mat/justNumber.mat

%feat=feat_with_NaN; 
feat=justNumbercsv;
feat_table=feat;
feat=table2array(feat);
label=table2array(lab(:,1));

%   selected best features
selected_feature_names={'TOTALBTUSPH','BTUNG','TOTALDOLSPH','DOLELAHUHEAT','TOTROOMS',...
    'WINDOWS','TOTALBTUWTH','BEDROOMS','OTHROOMS','LGTINNUM','CELLAR','DOLLAREL','LGTIN4',...
    'FUELHEAT', 'EQUIPAGE','NUMCFAN','MONEYPY','TYPEHUQ','STORIES'};

selected_features=zeros(1,size(feat_table,2));
for i=1:size(selected_feature_names,2)
    temp=find(ismember(feat_table.Properties.VariableNames,selected_feature_names(1:i)));
    if temp>0
        selected_features(1,temp)=1;
    end
end

%final dataset
fanal_dataset_table= feat_table(:,selected_features==1);
fanal_dataset=table2array(fanal_dataset_table);

%FUELHEAT
new_FUELHEAT=table(convert_categorical_features(fanal_dataset_table(:,8),6),'VariableNames',{'FUELHEAT'});
fanal_dataset_table(:,'FUELHEAT') = [];
fanal_dataset_table=[fanal_dataset_table new_FUELHEAT];

new_TYPEHUQ=table(convert_categorical_features(fanal_dataset_table(:,1),5),'VariableNames',{'TYPEHUQ'});
fanal_dataset_table(:,'TYPEHUQ') = [];
fanal_dataset_table=[fanal_dataset_table new_TYPEHUQ];

%run k-means
%[idx_kmeans,c_kmeans]=kmeans(fanal_dataset,5);

fanal_dataset_table_after_convert=fanal_dataset_table;


%load mat/kmeans_py.mat;
%run db-scan
% epsilon=1;
% minpts=10;
% [idx_dbscan,corepts_dbscan] = dbscan(fanal_dataset,epsilon,minpts);






