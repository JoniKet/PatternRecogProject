% Digit classify main function made for Pattern recognition course.
% Loads in hyperparameters and neural network weights from NetworkStructure.mat file
% Loads minumum values and maximum values from maxForNormalization and
% minForNormalizations
% IN ORDER TO RUN THIS, digit_classify_parameters and usedFunctions folders
% have to be added to MATLAB path!!!

function C = digit_classify(testdata)

    parameters = load("NetworkStructure.mat");
    normMin = load("minForNormalization.mat");
    normMax = load("maxForNormalization.mat");
    
    
    % ------------------------------------------------------------
    % Given timeseries preprocessing
    
    smoothed = expsmooth(testdata(:,1:2),500,10); % Exponential smoothing, already dropping Z axis (height)
    
    [eigenvectors,eigenvalues] = eig(cov(smoothed));
    eigenvector11 = eigenvectors(1,1);   
    eigenvector12 = eigenvectors(2,1);  
    eigenvector21 = eigenvectors(1,2);  
    eigenvector22 = eigenvectors(2,2);  
    eigenvalue1 = eigenvalues(1,1);
    eigenvalue2 = eigenvalues(2,2);
    
    centered = center(smoothed); % Centering
    
    rescaled = minmaxnorm(centered); % Digit normalization
    
    %------------------------------------------------------------
    % Feature extraction
    pixelWidth = 12; % hyperparameter of the solution that could increase accuracy
    pixels = zeros(pixelWidth,pixelWidth);
        [pixels,startX,startY,afterstartX,afterstartY,...
            beforeendX,beforeendY,endX,endY,startDirX,...
            startDirY,afterstartdirX,afterstartdirY,...
            beforeenddirX,beforeenddirY] = time2matrix2(rescaled,pixelWidth);

        dataWrangled(1,1:pixelWidth*pixelWidth) = reshape(pixels,1,[]);

        k = 1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = startX;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = startY;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = afterstartX;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = afterstartY;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = beforeendX;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = beforeendY;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = endX;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = endY;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = startDirX;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = startDirY;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = afterstartdirX;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = afterstartdirY;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = beforeenddirX;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = beforeenddirY;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = eigenvector11;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = eigenvector12;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = eigenvector21;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = eigenvector22;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = eigenvalue1;
        k = k+1;
        dataWrangled(1,pixelWidth*pixelWidth+k) = eigenvalue2;


    [temp,features] = size(dataWrangled);
    
    %temporarily adding min and max values of features in order to do
    %minmaxnormalization
    
    dataWrangled(2,:) = normMin(1).minForScaling;
    dataWrangled(3,:) = normMax(1).maxForScaling;
    
    %normalize the feature columns
    dataWrangled(:,pixelWidth*pixelWidth:features) = minmaxnorm(dataWrangled(:,pixelWidth*pixelWidth:features));
    dataWrangled = dataWrangled(1,:); % Removing the temporary min max rows
    
    
    %---------------------------------------------------------------------------
    % Neural Network classifier
    dataWrangled = dataWrangled';
    NNconfig = parameters(1).NNconfigStored;
    wHidden = parameters(1).wHiddenStored;
    wOutput = parameters(1).wOutputStored;
    actFunc = 'sigma';
    extendedInput = [dataWrangled; ones(1, size(dataWrangled, 2))];
    N = size(dataWrangled, 2); % number of data samples
    
    for i = 1:length(NNconfig) % for each hidden layer
     
      if i == 1
          yHidden{i} = forwardpropagate(extendedInput,wHidden{i},actFunc,N);
      else
          yHidden{i} = forwardpropagate(yHidden{i-1},wHidden{i},actFunc,N);
      end    
    end

    vOutput = wOutput' * yHidden{end}; % output layer weighted inputs
    yOutput = vOutput; % output layer (linear) output

    [~, testClass] = max(yOutput, [], 1);
    C = testClass-1;

end