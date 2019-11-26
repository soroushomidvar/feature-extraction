clc, clear, close 
load justNumber.mat;
feat=[justNumbercsv(:,1:394) justNumbercsv(:,397:418)]; % remove labels from dataset: TOTALBTU,TOTALDOL
after_pre=feat;
for i=1:size(feat,1)
    for j=1:size(feat,2)
    if isequal(table2array(feat(i,j)),-2)
            after_pre(i,j)={NaN};
    end
    end
end

continuous_feat_with_NaN= after_pre(:,260:end-8);

feat_with_NaN = rmmissing(after_pre);