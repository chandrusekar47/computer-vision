% Problem 1
clear; close all; clc;
world_points = load(fullfile('input', '3Dpoints.txt'));
camera_points = load(fullfile('input', '2Dpoints.txt'));
camera_matrix = compute_camera_matrix(world_points, camera_points);
homo_3D_points = [world_points'; ones(1, size(world_points, 1))];
transformed_homo_2D_points = camera_matrix * homo_3D_points;
transformed_2D_points = convert(transformed_homo_2D_points);
plot(camera_points, 'r+');
hold on;
plot(transformed_2D_points, 'yo');

% Problem 2
sum_of_squared_error = compute_sum_square_error(camera_points, transformed_2D_points);
disp(sum_of_squared_error);

% Problem 3, 4, 5
clear; clc; close all;
all_points = load('input\homography.txt');
number_of_points = size(all_points, 1);
first_image = [all_points(:, 1) all_points(:, 2)];
second_image = [all_points(:, 3) all_points(:, 4)];
norm_homography = compute_homography(first_image, second_image);
transformed_points = norm_homography * [first_image'; ones(1, number_of_points)];
new_points = convert(transformed_points);
plot(second_image, 'r+');
hold on;
plot(new_points, 'bo');
hold off;
square_error = compute_sum_square_error(second_image, new_points);
disp(square_error);