function [feature_matrix] = circularNeighbors(img, center_x, center_y, radius)
    num_cols = 2*radius;
    num_rows = 2*radius;
    [height, width, ~] = size(img);
    top_left_x = floor(center_x - radius);
    top_left_y = floor(center_y - radius);
%     % handle scenario when the distance between center of the image and the
%     % left/top edge is less than radius
%     num_cols = num_cols - (top_left_x-(center_x - radius));
%     num_rows = num_rows - (top_left_y-(center_y - radius));
%     % handle scenario when the distance between center of the image and the
%     % right/bottom edge is less than radius
    bottom_right_x = top_left_x + num_cols;
    bottom_right_y = top_left_y + num_rows;
%     num_cols = num_cols - ((center_x + radius) - bottom_right_x);
%     num_rows = num_rows - ((center_y + radius) - bottom_right_y);
    % center inside the meshgrid
    % relative to 1-numcols, 1-numrows
    relative_center_x = center_x - top_left_x + 1;
    relative_center_y = center_y - top_left_y + 1;
    [X, Y] = meshgrid(1:num_cols, 1:num_rows);
    % get all points inside the circle
    circle_points = ((X-relative_center_x).^2 + (Y-relative_center_y).^2 ) <= radius^2;
    % create a bounding box around the circle and compute the feature matrix
    % for all pixels in the bounding box
    bounding_box_feature_matrix = generate_feature_matrix(img, top_left_x, top_left_y, num_cols, num_rows);
    transposed_circle_points = circle_points';
    % change size of circle_points to Kx5 to match the dimensions of the
    % bounding box feature matrix.
    vectorized_circle_points = repmat(transposed_circle_points(:), 1, 5);
    % zero out all entries in the bounding_box_feature_matrix where the point is not
    % in circle
    bounding_box_feature_matrix = bounding_box_feature_matrix .* vectorized_circle_points;
    % filter out rows with all zeros values
    feature_matrix = bounding_box_feature_matrix(all(bounding_box_feature_matrix, 2), :);
    % change all x and y to be relative to the original center
    feature_matrix(:, 1) = feature_matrix(:, 1) + center_x - relative_center_x;
    feature_matrix(:, 2) = feature_matrix(:, 2) + center_y - relative_center_y;
end