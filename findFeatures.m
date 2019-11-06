function y= findFeatures(feat_table,Sf)
a=[
find(strcmpi(feat_table.Properties.VariableNames,'WASHLOAD'))
find(strcmpi(feat_table.Properties.VariableNames,'DRYRUSE'))
find(strcmpi(feat_table.Properties.VariableNames,'LGTOUTNUM'))
find(strcmpi(feat_table.Properties.VariableNames,'TOTALBTUSPH'))
find(strcmpi(feat_table.Properties.VariableNames,'DOLELAHUHEAT'))
find(strcmpi(feat_table.Properties.VariableNames,'TOTALDOLSPH'))
find(strcmpi(feat_table.Properties.VariableNames,'SOLAR'))
find(strcmpi(feat_table.Properties.VariableNames,'TOTROOMS'))
find(strcmpi(feat_table.Properties.VariableNames,'WINDOWS'))
find(strcmpi(feat_table.Properties.VariableNames,'MONEYPY'))
];
y = ismember(a',Sf);
end
