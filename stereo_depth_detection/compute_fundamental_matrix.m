function [fundamental_matrix] = compute_fundamental_matrix (image1_points, image2_points)
    [norm_img_1_points, img_1_trans_mat] = transform_points(image1_points);
    [norm_img_2_points, img2_trans_mat] = transform_points(image2_points);
    matrix_a = [norm_img_1_points .* norm_img_2_points(:, 1) norm_img_1_points .* norm_img_2_points(:, 2) norm_img_1_points];
    [eig_vectors, eig_values] = eig(matrix_a' * matrix_a);
    norm_funda_matrix = reshape(eig_vectors(:, diag(eig_values) ==  min(diag(eig_values))), 3, 3);
    norm_funda_matrix = norm_funda_matrix';
    norm_funda_matrix = norm_funda_matrix./sum(sum(norm_funda_matrix));
    [U, D, V] = svd(norm_funda_matrix);
    D(3, 3) = 0;
    rank_2_funda_matrix = U * D * V';
    fundamental_matrix = img2_trans_mat' * rank_2_funda_matrix * img_1_trans_mat;
end