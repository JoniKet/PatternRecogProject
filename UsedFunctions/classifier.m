function [class, Simil] = classifier(data, ideals, y, w)
% P�ivitetty 11.5.2004
% T�m� funktio luokittelee vektoreita similaarisuusmittojen avulla
%
%   INPUT:
%
%   data    =    datamatrix
%   ideals  =    idealvectors
%   y(1)    =    p-value in similarity measure
%   y(2)    =    m-value in similarity measure 
%   y(3)    =    used similarity measure
%
%   w       =    weights (default is set to ones)%
%
%   OUTPUT:
%
%   class   =    column vector of the classes in which the samples are classified
%   Simil   =    similarity values for each class

[nc, v_dim] = size(ideals);  
d_dim = size(data,1);  


Simil = zeros(d_dim, nc); 

if nargin==3    
    w=ones(1,v_dim);
end

if nargin==2   
    y = [1, 1, 1];   
    w=ones(1,v_dim);
end

for j = 1 : nc  

    Ideal = repmat(ideals(j,:),d_dim,1);

%Generalized Lukasiewics similarity with generalized mean: 
if y(3) == 1
Simil(:,j) = ((1/v_dim)*sum(((1-abs(data.^y(1)-Ideal.^y(1))).^(y(2)/y(1)))*diag(w),2)).^(1/y(2)); %lukasiewicz

%Possible way to speed it up
%Ideal = repmat(ideals(j,:).^y(1),d_dim,1);
%Simil(:,j) = ((1/v_dim)*sum(((1-abs(data.^y(1)-Ideal)).^(y(2)/y(1)))*diag(w),2)).^(1/y(2)); %lukasiewicz


end
    
end

[simil_val, class] = max(Simil');
class=class';