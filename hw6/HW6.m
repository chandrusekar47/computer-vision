% Problem 1
close all;clc;clear;
img = double(imread(fullfile('input','target.jpg')));
[height, width, ~] = size(img);
model_cov_matrix = [47.917 0 -146.636 -141.572 -123.269; 0 408.250 68.487 69.828 53.479; -146.636 68.487 2654.285 2621.672 2440.381; -141.572 69.828 2621.672 2597.818 2435.368; -123.269 53.479 2440.381 2435.368 2404.923];
patch_rows = 70;
patch_cols = 24;
last_col = width - patch_cols;
last_row = height - patch_rows;
k = 1;
cov_diff_mat = zeros(last_row, last_col);
for x=1:last_col
    for y=1:last_row
        feature_matrix=generate_feature_matrix(img, x, y, patch_cols, patch_rows);
        patch_cov = cov(feature_matrix, 1);
        cov_diff_mat(y,x) = covariance_distance(model_cov_matrix, patch_cov);
    end
end
[row, col] = find_element(cov_diff_mat, min(cov_diff_mat(:)));
figure;imagesc(cov_diff_mat);
figure;imagesc(img/255);
hold on;
rectangle('Position', [col row patch_cols patch_rows], 'EdgeColor', 'yellow', 'LineWidth', 3);
hold off;
figure;surf(cov_diff_mat);axis('ij');
pause;

% Problem 2
clc; close all;
img = double(imread(fullfile('input','target.jpg')));
center_x = 275;
center_y = 25;
radius = 20;
non_zero_rows = circularNeighbors(img, center_x, center_y, radius);
x = non_zero_rows(:, 1);
y = non_zero_rows(:, 2);
imagesc(img/255);
hold on;
% plotting all points considered by the circularNeighbors function, to
% verify if the right points are considered by the circular neighbors
for n=1:size(x, 1)
    plot(x(n)+center_x, y(n)+center_y, 'y.', 'MarkerSize', 20);
end
plot(center_x, center_y, 'r+', 'MarkerSize', 20);
hold off;

% Problem 3
clc;close all;
h = 20;
bins = 16;
hist_cube = colorHistogram(feature_matrix, bins, center_x, center_y, h);

q_model = hist_cube;
p_test = hist_cube;

% Problem 4
weights = meanShiftWeights(feature_matrix, q_model, p_test);

% Problem 5
clc; clear; close all;
img1 = double(imread(fullfile('input','img1.jpg')));
img2 = double(imread(fullfile('input','img2.jpg')));
radius = 25;
h = 25;
center_x = 150.0;
center_y = 175.0;
bins = 16;
number_of_iterations = 25;
original_feature_matrix = circularNeighbors(img1, center_x, center_y, radius);
q_model = colorHistogram(original_feature_matrix, bins, center_x, center_y, h);
figure;imagesc(img1/255);
hold on;
viscircles([center_x center_y], [radius]);
plot(center_x, center_y, 'y+', 'MarkerSize', 5);
hold off;
x = center_x;
y = center_y;
coordinates = [x y];
for n=1:number_of_iterations
    feature_matrix = circularNeighbors(img2, x, y, radius);
    p_test = colorHistogram(feature_matrix, bins, x, y, h);
    weights = meanShiftWeights(feature_matrix, q_model, p_test);
    sum_of_weights = sum(weights);
    new_coordinate = sum([feature_matrix(:, 1) .* weights', feature_matrix(:, 2) .* weights'], 1) ./ sum_of_weights;
    x = new_coordinate(1);
    y = new_coordinate(2);
    coordinates = [coordinates; x y];
    fprintf('New coordinate: (%g, %g)\n', x, y);
end
for n=1:size(coordinates, 1)
    imagesc(img2/255);
    hold on;
    viscircles([coordinates(n, 1) coordinates(n, 2)], radius);
    plot(coordinates(n, 1), coordinates(n, 2), 'yellow+', 'MarkerSize', 5);
    if n > 1 
        title(sprintf('Iteration: %d, Distance between last 2 points: %0.5g \n Point: (%g, %g)', n, sqrt( (coordinates(n, 1) - coordinates(n-1, 1)).^2 +(coordinates(n, 2) - coordinates(n-1, 2)).^2 ), coordinates(n ,1), coordinates(n, 2)));
    end
    hold off;
    pause(1);
end