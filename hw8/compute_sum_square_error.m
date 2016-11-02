function [sum_sq_err] = compute_sum_square_error(points, other_points) 
    sum_sq_err = sum(sum((points - other_points).^2, 2));
end