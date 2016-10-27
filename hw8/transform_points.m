function [transformed_points, transform_matrix] = transform_points(points)
    points = points';
    mean_x = mean(points(1, :));
    mean_y = mean(points(2, :));
    s = sqrt(2) / mean(sqrt(((points(1, :) - mean_x).^2 + (points(2, :) - mean_y).^2)));
    transform_matrix = [s 0 -s*mean_x; 0 s -s*mean_y; 0 0 1];
    transformed_points = transform_matrix * [points; ones(1, size(points, 2))];
end