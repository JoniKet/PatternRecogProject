% This script loads data to a single struct
% Made for pattern recognition course fall 2019
function [data,labels] = loadData()
    labels = zeros(1000,1); k = 1;
    for i = 1:100
        for j = 0:9
            if i < 10
                obsNumber = ['000',num2str(i)];
            elseif i < 100
                obsNumber = ['00',num2str(i)];  
            else
                obsNumber = ['0',num2str(i)];
            end
            tempLoad = load(['stroke_',num2str(j),'_',obsNumber,'.mat']);
            data(k) = tempLoad;
            labels(k,1) = j;
            k = k+1;
        end
end