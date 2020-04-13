% Send data through sigmoid function 1/1+e^-x
function y = sigma(x)

    y = 1./(1+exp(-x));

end