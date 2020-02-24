clc, clear, close
%   load .mat files
load mat/dic.mat;
load mat/label.mat;
load mat/justNumber.mat;
load mat/continuous_feat_with_NaN.mat;
load mat/feat_with_NaN.mat;


%   create dictionary
M_cat = containers.Map(cellstr(char(table2array(dic(:,1)))),cellstr(char(table2array(dic(:,2)))),'UniformValues',false);
M_des = containers.Map(cellstr(char(table2array(dic(:,1)))),cellstr(char(table2array(dic(:,5)))),'UniformValues',false);

%   remove labels from dataset: TOTALBTU,TOTALDOL (all features with -2,-8,-9)
feat=[justNumbercsv(:,1:394) justNumbercsv(:,397:418)];

%   only continuous features
%feat=continuous_feat_with_NaN; 

%   only continuous features
%feat=feat_with_NaN; 

feat_table=feat;
feat=table2array(feat);
label=table2array(lab(:,1));

%   normalize label and all features
%normalized_features= Normalize(feat);
normalized_features= feat;
%normalized_label=Normalize(label);
normalized_label=label;

mcord_normalized_features=zeros(5,size(normalized_features,2));
for i = 1:size(normalized_features,2)
    
    %remove NaN
    [feature_without_NaN,label_without_NaN]= remove_NaN(normalized_features(:,i),normalized_label);
    
    %   normalize label and selected feature
    normalized_feature_without_NaN=normalize_function(feature_without_NaN);
    normalized_label_without_NaN=normalize_function(label_without_NaN);
    
    %   run mcorrdis
    [mcord, mcovd, pValue, tStatistic, dof] = mcorrdis(normalized_feature_without_NaN,normalized_label_without_NaN);
    mcord_normalized_features(1,i)=mcord;
    mcord_normalized_features(2,i)=mcovd;
    mcord_normalized_features(3,i)=pValue;
    mcord_normalized_features(4,i)=tStatistic;
    mcord_normalized_features(5,i)=dof;
end

mcord_normalized_features_table=array2table(mcord_normalized_features);
mcord_normalized_features_table.Properties.VariableNames=feat_table.Properties.VariableNames;

%	sort
out_1 = sort_table(mcord_normalized_features_table,1);
out_2 = sort_table(mcord_normalized_features_table,2);
out_3 = sort_table(mcord_normalized_features_table,3);
out_4 = sort_table(mcord_normalized_features_table,4);
out_5 = sort_table(mcord_normalized_features_table,5);

%   load saved out files
%load mat/out_1.mat;
%load mat/out_2.mat;
%load mat/out_3.mat;
%load mat/out_4.mat;
%load mat/out_5.mat;

%   category and description based on sorted files
cat_1=[]; cat_2=[]; cat_3=[]; cat_4=[]; cat_5=[];
des_1=[]; des_2=[]; des_3=[]; des_4=[]; des_5=[]; 
for i = 1:size(normalized_features,2)
    cat_1=[cat_1; convertCharsToStrings(M_cat(char(out_1.Properties.VariableNames(i))))];
    des_1=[des_1; convertCharsToStrings(M_des(char(out_1.Properties.VariableNames(i))))];
    cat_2=[cat_2; convertCharsToStrings(M_cat(char(out_2.Properties.VariableNames(i))))];
    des_2=[des_2; convertCharsToStrings(M_des(char(out_2.Properties.VariableNames(i))))];
    cat_3=[cat_3; convertCharsToStrings(M_cat(char(out_3.Properties.VariableNames(i))))];
    des_3=[des_3; convertCharsToStrings(M_des(char(out_3.Properties.VariableNames(i))))];
    cat_4=[cat_4; convertCharsToStrings(M_cat(char(out_4.Properties.VariableNames(i))))];
    des_4=[des_4; convertCharsToStrings(M_des(char(out_4.Properties.VariableNames(i))))];
    cat_5=[cat_5; convertCharsToStrings(M_cat(char(out_5.Properties.VariableNames(i))))];
    des_5=[des_5; convertCharsToStrings(M_des(char(out_5.Properties.VariableNames(i))))];
end

cat_des_1=(horzcat(cat_1,des_1))';
cat_des_2=(horzcat(cat_2,des_2))';
cat_des_3=(horzcat(cat_3,des_3))';
cat_des_4=(horzcat(cat_4,des_4))';
cat_des_5=(horzcat(cat_5,des_5))';

T1=array2table(cat_des_1);
T2=array2table(cat_des_2);
T3=array2table(cat_des_3);
T4=array2table(cat_des_4);
T5=array2table(cat_des_5);


%	save sorted outputs
writetable(T1,'output/cat_des_1.csv','WriteVariableNames',0);
writetable(T2,'output/cat_des_2.csv','WriteVariableNames',0);
writetable(T3,'output/cat_des_3.csv','WriteVariableNames',0);
writetable(T4,'output/cat_des_4.csv','WriteVariableNames',0);
writetable(T5,'output/cat_des_5.csv','WriteVariableNames',0);

writetable(out_1,'output/out_1.csv'); 
writetable(out_2,'output/out_2.csv'); 
writetable(out_3,'output/out_3.csv'); 
writetable(out_4,'output/out_4.csv'); 
writetable(out_5,'output/out_5.csv'); 
