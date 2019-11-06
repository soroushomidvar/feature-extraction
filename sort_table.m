function [out]   = sort_table(in,row)
% for fff=1:size(in,2)
%     [M I]=max(in(1,:));
%     temp = movevars(temp,I,'Before',1);
%     in(:,I)=-inf;
% end
% out=temp;

for s=1:size(in,2)
    for ss=1:size(in,2)
        if table2array(in(row,s))>table2array(in(row,ss))
            in = movevars(in,s,'Before',ss);
        end
    end
end
out=in;
end