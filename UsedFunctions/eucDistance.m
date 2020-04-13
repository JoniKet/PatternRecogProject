% Euclidean distance function made for pattern recognition course

function distance = eucDistance(point1,point2)

    distance = sqrt(sum((point1-point2).^2));

end