% Exponential smoothing function made for Pattern recognition practical
% assignment
function [ X ] = expsmooth( X, fs, tau )
% EXPSMOOTH Exponential smoothing. 

    % T sampling period (ms)
    T = 1E3/fs;
    % compute the smoothing constant
    alpha = exp( -T/tau );
    % get number of column vector signals (M) and their lengths (N)
    [ N, M ] = size( X );
    % for each column vector signal
    for m = 1:M
        % for each sample
        for n = 2:N
            % apply the exponential smoother [1]
            X(n,m) = alpha*X(n-1,m) + (1-alpha)*X(n,m);
        end
    end
% EOF 
