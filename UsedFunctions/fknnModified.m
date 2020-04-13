% Modified FKNN algorithm from Fuzzy Data analysis course templates
% Made for Pattern Recognition course practical assignment by Joni Kettunen

function [trainingSetAcc,validationACC,predictedLabels] = fknnModified(train_data,train_data_y,test_data,test_data_y)

    % KNN PARAMETERS
    [rows,dims] = size(train_data);
    N=50; % How many times random division to training set and testing set is done
    K=[1:5]; % numbers of k-nn to test
    rn = 1/2; % amount of data in validation and split set
    mink = dims-20; % minumum amount of variables to include
    maxk = dims; % max amount of variables to include

    % K-NN loop

    for k = mink:1:maxk

      data_new = [train_data(:,1:k) train_data_y]; % Defines how many variables to include
      [rows, columns] = size(data_new);

      % sorting the observations with the example script given in exercies. 
      [data, lc, cs]= init_data(data_new,1:columns-1,columns);


      v=columns-1;
      c=columns;

      accuracy=[]; %Store the classification accuracies
      %Implemented with crossvalidation:

      rn_train=ones(1,length(lc))*rn(1);

      for i=1:N %Randomly repeat division to training set and testing set
         train_ind=[];
         for j=1:length(lc) %For each class
             temp=randperm(lc(j))-1; %random permutation of the class sample indexes
             %Indexes of the training set:
             train_ind=[train_ind, cs(j)+temp(1:floor(lc(j)*rn_train(j)))];
             %Indexes of the testing set:
         end
         test_ind=setxor([1:size(data,1)],train_ind); %All the indexes which are not in training set
         %are selected to testing set.
         test=data(test_ind,1:v); %data for verification
         train=data(train_ind,1:v); %data for training
         test_labels=data(test_ind,c); %Class labels for testing set
         train_labels=data(train_ind,c); %Class labels for training set
         [y,mem, numhits] = fknn(train,...
             train_labels, test,test_labels, K,0,'true');
      %    results=numhits/length(test_labels);

         for l = 1:max(K) % choosing which k value produces highest accuracy
            acc(l) = sum(y(:,l) == test_labels)/length(test_labels);
         end
         accuracy = [accuracy; acc];
    %      fprintf('Check %2.0f out of %2.0f \n',i,N);

      end
      MeansACC(:,k) = mean(accuracy);    %Mean classification accuracies from 30 repetation rows = number of neighbouts columns = number of variables
      fprintf('Completion %2.0f out of %2.0f \n',k,maxk);
    end
    % getting rid of the zero columns
    % 
    MeansACC = MeansACC(:,mink:end);


    accArray = reshape(MeansACC,[],1);
    varArray = []; kArray = [];
    for i = 1:max(K)
      varArray = [varArray mink:maxk];
    end
    for i = 1:(maxk-mink+1)
      kArray = [kArray 1:max(K)];
    end
    % plotting ACC
    figure(2)
    hold on
    scatter3(kArray,varArray,accArray,'r');
    [xq,yq] = meshgrid(min(kArray):.01:max(kArray), min(varArray):.01:max(varArray));
    vq = griddata(kArray,varArray,accArray,xq,yq);
    mesh(xq,yq,vq);
    xlabel('Number of k nearest neighbours in algo'); ylabel('Number of variables included from the data'); zlabel('Classification model Accuracy');
    title('Accuracy w.r.t amount of k-nn neighbors and variables from the data')
    grid on;
    hold off


    [trainingSetAcc,idx] = max(accArray);
    
    kArray(idx)
    varArray(idx)
    
    
    
    % Calculating model accuracy with the validation data
    
    train_data_y = train_data_y +1;
    test_data_y = test_data_y +1;
    
    
    [y2,mem, numhits] = fknn(train_data(:,1:varArray(idx)),...
         train_data_y(:,1), test_data(:,1:varArray(idx)), test_data_y(:,1),kArray(idx),0,'true');
    
    
    predictedLabels = y2;
    validationACC = sum(y2 == test_data_y)/length(test_data_y);
    
    

end