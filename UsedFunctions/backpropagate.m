% Backpropagation function created for advanced data analysis course neural
% network stuff
% Backpropagates the HIDDEN layers!
%Inputs
% deltaNext: the error in the following layer 
% wNext: network weights in the next layer
% yHidden: Output on specific layer
% rho: learning rate
% input: input to the neuron layer
% wHidden: current weights of the layer
% actFunc: activation function type, "tanh","sigma" or "relu"
% vHidden: previous layer output before activation function
function [wHidden,deltaHidden] = backpropagate(deltaNext,wNext,yHidden,rho,input,wHidden,actFunc,vHidden)

    
    if strcmp(actFunc,'tanh') == true
        deltaHidden = (wNext(1:end-1, :) * deltaNext) .* ...
        (1 - yHidden(1:end-1, :) .^ 2);
    end

    if strcmp(actFunc,'sigma') == true
        deltaHidden = (wNext(1:end-1, :) * deltaNext) .* ...
        (yHidden(1:end-1,:) .* (1-yHidden(1:end-1,:)));
    end
    
    if strcmp(actFunc,'relu') == true
        deltaHidden = (wNext(1:end-1, :) * deltaNext) .* ...
        relu(vHidden);
    end
    

    deltawHidden = -rho*input*deltaHidden';

    wHidden = wHidden + deltawHidden;

end