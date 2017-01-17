clear; clc; close all;
training_data = load ('input\train.txt');
test_data = load ('input\test.txt');

X = training_data(:, 1:2);
Y = test_data(:, 1:2);
values = [1, 5, 11, 15];
ground_truth = test_data(:, 3);
for k=values
    [idx, dist] = knnsearch(X, Y, 'K', k);
    k_matches = zeros(size(Y, 1), k);
    for i=1:k
        k_matches(:, i) = training_data(idx(:,i), 3);
    end
    if k ~= 1
        classified_labels = mode(k_matches')';
    else 
        classified_labels = k_matches;
    end
    class_1 = numel(find(classified_labels == 1));
    class_2 = numel(find(classified_labels == 2));
    mis_matched_points = test_data(ground_truth ~= classified_labels, 1:2);
    class_1_matches = test_data(classified_labels == 1, 1:2);
    class_2_matches = test_data(classified_labels == 2, 1:2);
    figure;
    hold on;
    title({sprintf('k-Nearest Neighbors classification k=%d', k), sprintf('Total points: %d. Class 1 points: %d, Class 2 points: %d', size(test_data,1), class_1, class_2), sprintf('Number of incorrect matches: %d', size(mis_matched_points,1))});
    plot(class_1_matches(:, 1), class_1_matches(:, 2), 'r.');
    plot(class_2_matches(:, 1), class_2_matches(:, 2), 'b.');
    plot(mis_matched_points(:, 1), mis_matched_points(:, 2), 'ko');
    hold off;
    save_current_frame(fullfile('out', sprintf('%d-nearest-plot.png',k)));
    fprintf('k: %d, Number of mismatches: %d\n', k, numel(find(ground_truth ~= classified_labels)));
end
pause;
close all;