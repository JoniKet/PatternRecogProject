%Similarity algorithm created for pattern recognition course

function distance = similarity(testTimeSeries,dataTimeSeries)

    % First step is to define the speeding factor. Some people write
    % numbers faster than others, so the timeseries has to be scaled
    
    lenTest = length(testTimeSeries);
    lenData = length(dataTimeSeries);
    
    speedMult = lenData/lenTest;
    range = 5;
    
    distanceSum = 0;
    for i = 1:lenTest
        
        if round(speedMult*i)-range <= 0
            if round(speedMult*i) < 1
                dataPoint = dataTimeSeries(1:1+range,:);
            else
                dataPoint = dataTimeSeries(round(speedMult*i):round(speedMult*i)+range,:);
            end
            testPoint = testTimeSeries(i,:);
            
            distance = eucDistance(testPoint,dataPoint);
        
        elseif round(speedMult*i)-range > 0 && round(speedMult*i)+range < lenData
            testPoint = testTimeSeries(i,:);
            dataPoint = dataTimeSeries(round(i*speedMult)-range:round(i*speedMult)+range,:);
            
            distance = 69420;
            for j = 1:size(dataPoint,1)
                distanceTemp = eucDistance(testPoint,dataPoint(j,:));
                if distanceTemp < distance
                    distance = distanceTemp;
                end
            end
            
        elseif round(speedMult*i)-range > 0 && round(speedMult*i)+range > lenData
            testPoint = testTimeSeries(i,:);
            dataPoint = dataTimeSeries(round(i*speedMult)-range:round(i*speedMult),:);
            
            distance = 69420;
            for j = 1:size(dataPoint,1)
                distanceTemp = eucDistance(testPoint,dataPoint(j,:));
                if distanceTemp < distance
                    distance = distanceTemp;
                end
            end
        end
        
        distanceSum = distanceSum + distance;
        
    end

end