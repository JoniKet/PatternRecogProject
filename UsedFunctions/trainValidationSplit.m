% Function that splits the data into training and validation parts
% Created for pattern recognition course practical exercise
% Since random permutations are not done, do not use this in other
% applications. The order of digits is already defined in loading phase.

function [train_data,train_data_y,validation_data,validation_data_y] = trainValidationSplit(dataWrangled,labels,split)

    train_data = dataWrangled(1:round(length(dataWrangled(:,1))*split),:); % dataset that is used for cross validation
    train_data_y = labels(1:round(length(dataWrangled(:,1))*split),end);
    validation_data = dataWrangled(length(train_data):end,:); % data that is used to test the model with optimal parameters
    validation_data_y = labels(length(train_data):end,end);

end