% Function created to center the digit timeseries data
% made for Pattern recogntion course by JoniK
% Deducts mean from timeseries feature, specific for digits 3d assignment

function [centered] = center(numberTimesSeries)

    centered = numberTimesSeries;
    
    centered(:,1) = numberTimesSeries(:,1) - mean(numberTimesSeries(:,1)); % centering x axis
    centered(:,2) = numberTimesSeries(:,2) - mean(numberTimesSeries(:,2));  % centering y axis
%     centered(:,3) = numberTimesSeries(:,3) - mean(numberTimesSeries(:,3));  % centering z axis


end