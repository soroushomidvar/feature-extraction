load mat/feat_with_NaN.mat
selected_feature_names={'FUELHEAT','TYPEHUQ'};

feat=feat_with_NaN; 
feat_table=feat;
feat=table2array(feat);

selected_features=zeros(1,size(feat_table,2));
for i=1:size(selected_feature_names,2)
    temp=find(ismember(feat_table.Properties.VariableNames,selected_feature_names(1:i)));
    if temp>0
        selected_features(1,temp)=1;
    end
end

fanal_dataset_table= feat_table(:,selected_features==1);
fanal_dataset=table2array(fanal_dataset_table);
