% This function propagates forward a neural network hidden layer
% INPUTS
% input: input to the hidden layer
% wHidden: weights of the hidden layer
% actFunc: Activation function to used, 'tanh', 'sigma' or 'relu
% N: number of samples in training set
function [yHidden,vHidden] = forwardpropagate(input,wHidden,actFunc,N)

    vHidden = wHidden' * input;

    if strcmp(actFunc,'tanh') == true
      yHidden = tanh(vHidden);
    end

    if strcmp(actFunc,'sigma') == true
      yHidden = sigma(vHidden);
    end
    
    if strcmp(actFunc,'relu') == true
      yHidden = relu(vHidden);
    end


     yHidden = [yHidden; ones(1,N)];



end