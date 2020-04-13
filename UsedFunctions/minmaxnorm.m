% Minmax normalization function. Made by JoniK for ADAML course
% works for dataframes where rows = observations and columns are features
% Each feature has own scaling

function xnew = minmaxnorm(x)

    [ndata,features] = size(x);
    xnew = zeros(ndata,features);
    
    for i = 1:features
    
        amin = min(x(:,i));
        amax = max(x(:,i));
        diffv = amax-amin;
        
        xnew(:,i) = (x(:,i)-amin)./diffv;
        
    end
    
    
end