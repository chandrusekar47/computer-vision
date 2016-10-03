clc; clear; close all;
img1 = double(imread('input\img1.jpg'));
img2 = double(imread('input\img2.jpg'));
radius = 25;
h = 25;
center_x = 150.0;
center_y = 175.0;
bins = 16;
number_of_iterations = 25;
original_feature_matrix = circularNeighbors(img1, center_x, center_y, radius);
q_model = colorHistogram(original_feature_matrix, bins, center_x, center_y, h);

x = center_x;
y = center_y;
imagesc(img1/255);
hold on;
plot(x, y, 'yellow+', 'MarkerSize', 5);
hold off;
pause;
close all;
imagesc(img2/255);
hold on;
coordinates = [x y];
for n=1:number_of_iterations
    feature_matrix = circularNeighbors(img2, x, y, radius);
    p_test = colorHistogram(feature_matrix, bins, x, y, h);
    weights = meanShiftWeights(feature_matrix, q_model, p_test);
    sum_of_weights = sum(weights);
    new_coordinate = sum([feature_matrix(:, 1) .* weights', feature_matrix(:, 2) .* weights'], 1) ./ sum_of_weights;
    x = new_coordinate(1);
    y = new_coordinate(2);
    fprintf('New coordinate: (%g, %g)', x, y);
    coordinates = [coordinates; new_coordinate];
    plot(x, y, 'yellow+', 'MarkerSize', 5);
    title(sprintf('Distance between last 2 points: %0.5g', sqrt( (coordinates(end, 1) - coordinates(end-1, 1)).^2 +(coordinates(end, 2) - coordinates(end-1, 2)).^2 )));
    pause(1);
end
hold off;