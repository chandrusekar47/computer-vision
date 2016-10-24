function [inhomogenous_coordinates] = convert(homogenous_coordinates) 
    inhomogenous_coordinates(1, :) = homogenous_coordinates(1, :) ./ homogenous_coordinates(3, :);
    inhomogenous_coordinates(2, :) = homogenous_coordinates(2, :) ./ homogenous_coordinates(3, :);
    inhomogenous_coordinates = inhomogenous_coordinates';
end