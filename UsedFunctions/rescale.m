% Rescaling digit function created for the Pattern Recognition course
% Idea taken from the link below
%https://github.com/GMarzinotto/Leap-Motion-Gestures/blob/master/preprocessing_and_feature_extraction/rescale_digit.m
function rescaled = rescale(numberTimeseries)
    
    rescaled = numberTimeseries;

    scalingFactor = (max(numberTimeseries(:,2)) - min(numberTimeseries(:,2))); %take scaling factor from y axis
    
    % If each column would be scaled seperately that could lead into
    % problems with for example x axis one number 1. Visual representation
    % of "incorrect" rescaling when scaling each dimension on its own
    % explain this problem
    
    rescaled(:,1) = numberTimeseries(:,1)/scalingFactor;
    rescaled(:,2) = numberTimeseries(:,2)/scalingFactor;
    rescaled(:,3) = numberTimeseries(:,3)/scalingFactor;


end