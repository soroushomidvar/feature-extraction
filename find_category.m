function [cat]   = find_category(name)
load dic.mat;
%     for s=1:size(dic,1)
%         if (dic(s,1)==name)
%             cat=dic(s,2);
%             break
%         end
%     end
    num = find(dic(:,1)==name);
    cat=dic(num,2);
end