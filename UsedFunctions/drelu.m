%dRelu derivative of rectified linear units function
% Can be used in NN backpropagation process

function y = drelu(x)
    [rows,columns] = size(x);
    y = zeros(rows,columns);
    for i = 1:rows
        for j = 1:columns
            if x(i,j) > 0
                y(i,j) = 1;
            else
                y(i,j) = 0;
            end
        end
    end
end