% Function that transforms time series data into matrix form, where each
% matrix axis represent x and y axis of a image.
% INPUTS
% numberTimeSeries: timeseries input. Expected rows as observations and two
% columns as features
% pixelWidth: resolution of the image
% OUTPUT:
% pixels: the resulting image
% startX: time series start location X axis
% startY: time series start location Y axis
% afterstartX: time series location 33% values gone through
% afterstartY: time series location 33% values gone through
% beforeendX: time series location 66% values gone through
% beforeendY: time series location 66% values gone through
% endX: time series location end
% endY: time series location end
% startDirX: start direction on X axis
% startDirY start direction on Y axis
% afterstartdirX direction when 33% values gone through
% afterstartdirY direction when 33% values gone through
% beofreenddirX direction when 66% values gone through
% beofreenddirY direction when 66% values gone through
function [pixels,startX,startY,afterstartX,afterstartY,beforeendX,beforeendY,endX,endY,startDirX,startDirY,afterstartdirX,afterstartdirY,beforeenddirX,beforeenddirY] = time2matrix2(numberTimeseries,pixelWidth)
    pixels = zeros(pixelWidth,pixelWidth);
    sequence = linspace(0,1,pixelWidth+1);
    for z = 1:length(numberTimeseries) % Go through each point in the timeseries
        for i = 1:pixelWidth %width
            if numberTimeseries(z,1) >= sequence(i) && numberTimeseries(z,1) <= sequence(i+1) % if the x axis is active               
               for j = 1:pixelWidth % height                 
                   if numberTimeseries(z,2) >= sequence(j) && numberTimeseries(z,2) <= sequence(j+1) % if the x axis is active
                       pixels(i,j) = 1; 
                       
                       if z == 1
                           startX = i;
                           startY = j;
                           startDirX = numberTimeseries(z+1,1) - numberTimeseries(z,1);
                           startDirY = numberTimeseries(z+1,2) - numberTimeseries(z,2);
                       end
                       
                       
                       if z == floor(length(numberTimeseries)/3)
                           afterstartX = i;
                           afterstartY = j;
                           afterstartdirX = numberTimeseries(z+1,1) - numberTimeseries(z,1);
                           afterstartdirY = numberTimeseries(z+1,2) - numberTimeseries(z,2);
                       end
                       
                       if z == floor(length(numberTimeseries)/3)*2
                           beforeendX = i;
                           beforeendY = j;
                           beforeenddirX = numberTimeseries(z+1,1) - numberTimeseries(z,1);
                           beforeenddirY = numberTimeseries(z+1,2) - numberTimeseries(z,2);
                       end
                       
                       
                       
                       if z == length(numberTimeseries)
                           endX = i;
                           endY = j;   
                       end
                       
                       
                   end      
               end      
            end  
        end
    end
end