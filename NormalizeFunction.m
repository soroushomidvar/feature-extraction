function [NData]         = NormalizeFunction(Data)

    Data3                     = (Data-mean(Data))./std(Data);
    Data                      = Data3;
    if sum(isnan(Data(:)))
        Data(isnan(Data))            = 0;
    end
    NData=Data;
end