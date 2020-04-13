% Send data through inverse sigmoid function
% Can be used in NN backpropagation process
function y = dsigma(x)

    y = sigma(x).*(1-sigma(x));

end