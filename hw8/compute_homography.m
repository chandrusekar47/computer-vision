function [norm_homography] = compute_homography (first_image, transformed_image) 
    [first_homo_points, first_trans_matrix] = transform_points(first_image);
    [second_homo_points, second_trans_matrix] = transform_points(transformed_image);
    homography = compute_camera_matrix(first_homo_points(1:2, :)', second_homo_points(1:2, :)');
    norm_homography = inv(second_trans_matrix) * homography * first_trans_matrix;
    norm_homography = norm_homography ./ sum(sum(norm_homography));
end