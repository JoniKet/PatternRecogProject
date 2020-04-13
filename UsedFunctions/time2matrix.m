% Timeseries drawn to 3d matrix number function
% Made for Pattern Recognition course by Joni Kettunen

function pixels= time2matrix(numberTimeseries,pixelWidth)
    pixels = zeros(pixelWidth,pixelWidth);
    sequence = linspace(0,1,pixelWidth+1);
    for i = 1:length(numberTimeseries)
        for j = 1:length(sequence)-1    
            if numberTimeseries(i,1) >= sequence(j) && numberTimeseries(i,1) <= sequence(j+1)
                xaxis = j;
            end

            if numberTimeseries(i,2) >= sequence(j) && numberTimeseries(i,2) <= sequence(j+1)
                yaxis = j;
            end

        end
        pixels(xaxis,yaxis) = 1;
    end
end