  function [pca_letter,r2] = pcaFirst(x);
% keywords: principal components, multivariate analysis
% call: [t,p,r2] = pca(x);
% the function computes the PCA-decomposition of the matrix 'x'
% for all dimensions.
%
% INPUT:      x     The data matrix. Each observations is a row in x.
%
% OUTPUT:     t     The 'scores' of the observations, i.e. the projections
%                   of the observations on the principal axes.
%             p     The  principal axes
%             r2    The coefficient of determination
%
% NOTE  To get the correct pca interpretation, center 'x' before
%       calling the function.

 [m,n] = size(x);
 pca_letter = zeros(size(x));
 if m < n
    [p,s,u] = svd(x',0);
 else
    [u,s,p] = svd(x,0);
 end

 ssum = cumsum(diag(s).^2); nn = length(ssum);
 r2   = 100*ssum/ssum(nn);
 t    = u*s;

% Define first principal component as Y axis

pca_letter(:,2) = t(:,1);

% Second as X axis

pca_letter(:,1) = t(:,2);

% Third as Z axis
% 
% pca_letter(:,3) = t(:,3);