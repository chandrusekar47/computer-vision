function [feature_matrix] = generate_feature_matrix (img, top_left_x, top_left_y, num_cols, num_rows) 
    feature_matrix(:, 1) = repmat(1:num_cols, 1, num_rows)';
    feature_matrix(:, 2) = repeat_each_element(1:num_rows, num_cols)';
    patch = img(floor(top_left_y):(floor(top_left_y)+num_rows-1), floor(top_left_x):(floor(top_left_x)+num_cols-1), :);
    feature_matrix(:, 3) = reshape(patch(:, :, 1)', num_rows*num_cols, 1);
    feature_matrix(:, 4) = reshape(patch(:, :, 2)', num_rows*num_cols, 1);
    feature_matrix(:, 5) = reshape(patch(:, :, 3)', num_rows*num_cols, 1);
end