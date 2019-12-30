function [ y ] = recursive_XD( x )
if (size(x,1)>1)
    x=recursive_XD(x(1:end-1,1:end-1));
    y= zeros(size(x,1)+1,size(x,2)+1);
    y(1:size(x,1),1:size(x,2))=x;
    temp=zeros(size(y,1),1);
    for i=1:size(y,1)-1
        temp(i,1)=mean(y(i,1:end-1));
    end
    b=norm([temp(1:end-1,1)';y(1:end-1,end-1)']);
    temp(end,1)=b;
    y(:,end)=temp;
else
    y=[0 1];
end

