% Multilayer perceptron algorithm made for pattern recognition and advanced
% data analysis and machine learning courses. Trains neural network weights
% and tests those weights on specified test set
% INPUTS
% trainData: training data
% trainClass: labels of training data
% testData: testing data
% testLabels: labels of testing data
% maxEpochs: max iterations on the neural network training process
% actFunc: activation function chosen, can be 'tanh','sigma' or 'relu'
% NNconfig: Defines number of layers and neurons in each layer, for example
% [10 10] for two layers of 10 neurons in each layer
% stoplimit: Limit where to stop NN training iterations, if error drops
% below this, the training loop stops
% OUTPUT
% testClass: predicted classes for the testData
% t: number of epochs required to reach stopliit
% wHidden: hidden weights calculated for the NN
% wOutput: output layer weights calculated for the NN
% classAcc: accuracy of the neural network on testing set

function [testClass, t, wHidden, wOutput,classAcc] = ...
  mlp_custom_v3(trainData, trainClass, testData, testLabels, maxEpochs,actFunc,NNconfig,stoplimit)

%--------- Configured values

N = size(trainData, 2); % number of data samples
d = size(trainData, 1); % data dimensionality
nClass = max(trainClass); % number of classes
J = zeros(1, maxEpochs); % error function values
rho=0.0002; % learning rate

%----------- Definining missing values in function call
if ~exist('maxEpochs', 'var')
  maxEpochs=100000;
end

if ~exist('actFunc','var')
    actFunc = 'tanh'; % default activation function
end

if ~exist('NNconfig','var')
    NNconfig = [10 10]; % if no amount of layers is defined, two layers each 10 hidden nodes
end

%------------------ formating the weights with random values
trainOutput = zeros(nClass, N);
for i = 1:N
  trainOutput(trainClass(i), i) = 1;
end
extendedInput = [trainData; ones(1, N)]; % include bias
figure;
for i = 1:length(NNconfig) % for each hidden layer
    if i == 1
        wHidden{i} = (rand(d+1, NNconfig(i)) - 0.5) / 10; % hidden weights
    else
        wHidden{i} = (rand(NNconfig(i-1)+1, NNconfig(i)) - 0.5) / 10; % hidden weights
    end
end
wOutput = (rand(NNconfig(end)+1, nClass) - 0.5) / 10; % output weights

%------------------- Forward propagation loop for each layer
t = 0;
while true % train the MLP
  t = t+1;

  %-- Hidden layers
  
  for i = 1:length(NNconfig) % for each hidden layer
     
      if i == 1
          [yHidden{i},vHidden{i}] = forwardpropagate(extendedInput,wHidden{i},actFunc,N);
      else
          [yHidden{i},vHidden{i}] = forwardpropagate(yHidden{i-1},wHidden{i},actFunc,N);
      end    
  end
  
  %-- Output layer
  
  vOutput = wOutput' * yHidden{end}; % output layer weighted inputs
  yOutput = vOutput; % output layer (linear) output

  % -- Error calculation and deciding whether to stop iterating
  
  J(t) = 0.5 * sum(sum((yOutput - trainOutput) .^ 2)); % error

  if mod(t, 100) == 0 % plot the intermediate error
    semilogy(1:t, J(1:t));
    grid on;
    title(sprintf('Error up to iteration %d', t));
    drawnow
  end

  if J(t) < stoplimit % error very small
    break
  end

  if t >= maxEpochs % max number of iterations reached
    break
  end

  if t > 1
    if abs(J(t) - J(t-1)) < 1e-12 % error changed very little
      break
    end
  end

  % --Backpropagation
  
  %outputLayer
  deltaOutput = (yOutput - trainOutput);
  deltawOutput = -rho * yHidden{end} * deltaOutput';
  wOutput = wOutput + deltawOutput;
  
  %hiddenlayers
  
  for i = length(NNconfig):-1:1 % for each hidden layer
      if i == length(NNconfig) && i ~= 1 % if the hidden layer is closest to output layer
        [wHidden{i},deltaHidden] = backpropagate(deltaOutput,wOutput,yHidden{i},rho,yHidden{i-1},wHidden{i},actFunc,vHidden{i});
      elseif i == 1 && length(NNconfig) == 1  
        [wHidden{i},deltaHidden] = backpropagate(deltaOutput,wOutput,yHidden{i},rho,extendedInput,wHidden{i},actFunc,vHidden{i});
      elseif i == 1
        [wHidden{i},deltaHidden] = backpropagate(deltaHidden,wHidden{i+1},yHidden{i},rho,extendedInput,wHidden{i},actFunc,vHidden{i});
      else  
        [wHidden{i},deltaHidden] = backpropagate(deltaHidden,wHidden{i+1},yHidden{i},rho,yHidden{i-1},wHidden{i},actFunc,vHidden{i});
      end
  end

end

% Test the MLP

extendedInput = [testData; ones(1, size(testData, 2))];
N = size(testData, 2); % number of data samples

for i = 1:length(NNconfig) % for each hidden layer
     
      if i == 1
          yHidden{i} = forwardpropagate(extendedInput,wHidden{i},actFunc,N);
      else
          yHidden{i} = forwardpropagate(yHidden{i-1},wHidden{i},actFunc,N);
      end    
end

vOutput = wOutput' * yHidden{end}; % output layer weighted inputs
yOutput = vOutput; % output layer (linear) output

[tmp, testClass] = max(yOutput, [], 1);

classCorrect = (testClass == testLabels);
classAcc = sum(double(classCorrect)) / size(testData, 2);

fprintf('Classification accuracy %2.2f%%\n', ...
  100 * classAcc);
fprintf('NN layers: %d\n',length(NNconfig));
for i = 1:length(NNconfig)
    fprintf('%i neurons in layer %i \n',NNconfig(i),i);
end
fprintf('Epoch error stop limit: %i\n',stoplimit);


end
    

