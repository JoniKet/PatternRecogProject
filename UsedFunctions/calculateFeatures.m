% Function that transforms timeseries drawn letters into pixelmaps and adds
% several features as extra sauce to possibre increase future
% classification accuracy
% Created for Pattern Recognition course project by Joni Kettunen
% INPUTS
% data: the timeseries input data
% pixelwidth: resulting image resolution
% eigenvector11: raw image max variation direction
% eigenvector12: raw image max variation direction
% eigenvector21: raw image send highest variation direction
% eigenvector22: raw image send highest variation direction
% eigenvalue1: max variation direction variation amount
% eigenvalue2: second highest variation direction variation amount
% OUTPUTS
% dataWrangled: dataframe form of timeseries extracted features
function dataWrangled = calculateFeatures(data,pixelWidth,eigenvector11,eigenvector12,eigenvector21,eigenvector22,eigenvalue1,eigenvalue2)
    pixels = zeros(pixelWidth,pixelWidth,length(data));
    dataWrangled = zeros(length(data),pixelWidth*pixelWidth);
    
    for i = 1:length(data)
        

        numberTimeseries = data(i).pos;

        pixels = zeros(pixelWidth,pixelWidth);
        [pixels,startX,startY,afterstartX,afterstartY,...
            beforeendX,beforeendY,endX,endY,startDirX,...
            startDirY,afterstartdirX,afterstartdirY,...
            beforeenddirX,beforeenddirY] = time2matrix2(numberTimeseries,pixelWidth);

        dataWrangled(i,1:pixelWidth*pixelWidth) = reshape(pixels,1,[]);

        k = 1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = startX;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = startY;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = afterstartX;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = afterstartY;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = beforeendX;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = beforeendY;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = endX;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = endY;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = startDirX;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = startDirY;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = afterstartdirX;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = afterstartdirY;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = beforeenddirX;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = beforeenddirY;
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = eigenvector11(i);
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = eigenvector12(i);
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = eigenvector21(i);
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = eigenvector22(i);
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = eigenvalue1(i);
        k = k+1;
        dataWrangled(i,pixelWidth*pixelWidth+k) = eigenvalue2(i);

    end
end