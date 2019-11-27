function [feature,label]   = remove_NaN(f,l)
    [feature,TF] = rmmissing(f);
    label=l(~TF,:);
end