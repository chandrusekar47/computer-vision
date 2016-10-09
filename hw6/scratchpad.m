% function [] = scratchpad () 
clear; clc; close all;
number_of_images=30;
width = 640;
height= 480;
all_images = zeros(height, width, 3, number_of_images);
center_x  = 195;
center_y = 435;
radius = 30;
h = 30;
bins = 16;
all_image_positions = zeros(number_of_images, 2);
for n=1:number_of_images
    all_images(:, :, :, n) = double(imread(sprintf('input\\juggle\\juggle\\img (%d).jpg', n)));
end

number_of_iterations = 25;
original_feature_matrix = circularNeighbors(all_images(:, :, :, 1), center_x, center_y, radius);
q_model = colorHistogram(original_feature_matrix, bins, center_x, center_y, h);
all_image_positions(1, :) = [center_x center_y];
for m=2:number_of_images
    x = all_image_positions(m-1, 1);
    y = all_image_positions(m-1, 2);
    img2 = all_images(:, :, :, m);
    for n=1:number_of_iterations
        feature_matrix = circularNeighbors(img2, x, y, radius);
        p_test = colorHistogram(feature_matrix, bins, x, y, h);
        weights = meanShiftWeights(feature_matrix, q_model, p_test);
        sum_of_weights = sum(weights);
        new_coordinate = sum([feature_matrix(:, 1) .* weights', feature_matrix(:, 2) .* weights'], 1) ./ sum_of_weights;
        x = new_coordinate(1);
        y = new_coordinate(2);
    end
    q_model = p_test;
    fprintf('Image %d Coordinates: (%g, %g)\n', m, x, y);
    all_image_positions(m, :) = [x y];
end
% end
figure;
pause;
for n=1:number_of_images
    imagesc(all_images(:, :, :, n)/255);
    hold on;
    plot(all_image_positions(n, 1), all_image_positions(n, 2), 'yellow+', 'MarkerSize', 5);
    viscircles(all_image_positions(n, :), [radius]);
    hold off;
    pause(1);
end