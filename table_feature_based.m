function [f1,f2,f3,f4,f5,f6,f7]   = table_feature_based(out,cat_des)
categories={'energy characteristics' ;'behavioral characteristics' ;'appliances characteristics';'home characteristics'; 'Financial billing'; 'human characteristics'; 'flag' };
f1=[];f2=[];f3=[];f4=[];f5=[];f6=[];f7=[];
for s=1:size(cat_des,2)
    if(strcmp(cat_des(1,s),categories(1)))
        f1=[f1,in(:,s)];
    elseif (strcmp(cat_des(2,s),categories(2)))
        f2=[f2,in(:,s)];
    elseif (strcmp(cat_des(3,s),categories(3)))
        f3=[f3,in(:,s)];
    elseif (strcmp(cat_des(4,s),categories(4)))
        f4=[f4,in(:,s)];
    elseif (strcmp(cat_des(5,s),categories(5)))
        f5=[f5,in(:,s)];
    elseif (strcmp(cat_des(6,s),categories(6)))
        f6=[f6,in(:,s)];
    elseif (strcmp(cat_des(7,s),categories(7)))
        f7=[f7,in(:,s)];
    end
end

end