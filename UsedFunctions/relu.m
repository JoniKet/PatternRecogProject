% ReLU Rectifiec Linear units activation function for neural network
% Done for advanced data analysis and machine learning course

function y = relu(x);
    [rows,columns] = size(x);
    y = zeros(rows,columns);
    for i = 1:rows
        for j = 1:columns
            y(i,j) = max(0,x(i,j));
        end
    end
end