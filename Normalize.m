function [NData]         = NormalizeFunction_2(Data)
Dmin                      = min(Data); 
Dmax                      = max(Data);
diff                      = Dmax-Dmin;
Data                     = (Data-Dmin)./diff;
if sum(isnan(Data(:)))
    Data(isnan(Data))            = 0;
end
    NData=Data;
end