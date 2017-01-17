mkdir out;
close all; clear; clc;

closest_matches = [1 2 5 10 100 500];
search_img = double(imread('input\search.png'));
template = double(imread('input\template.png'));
[t_height, t_width, ~] = size(template);
patches = zeros (t_height, t_width, 3, size(closest_matches, 2));
scores = zeros(size(closest_matches, 2), 1);

% Problem 1 - SAD
[sad, points_and_scores] = sad_template_matching(search_img, template);
i = 1;
for n=closest_matches
    nth_match = points_and_scores(n, :);
    x =  nth_match(1, 1);
    y =  nth_match(1, 2);
    patch = search_img(y:y+t_height-1, x:x+t_width-1, :);
    patches(:,:,:, i) = patch;
    scores(i) = nth_match(1, 3);
    i = i+1;
end
for n=1:size(closest_matches, 2)
    figure;imagesc(patches(:, :, :, n)/255); title(sprintf('%d closest match, SAD score: %g', closest_matches(n), scores(n)));save_current_frame(fullfile('out', sprintf('sad-%d-closest-match.png', closest_matches(n))));
end
figure;plot(points_and_scores(:, 3));xlabel('k');ylabel('SAD');title('SAD score for kth closest match');save_current_frame(fullfile('out', 'sad-plot.png'));
pause;

% Problem 1 - SSD
close all;
i = 1;
[ssd, points_and_scores] = ssd_template_matching(search_img, template);
for n=closest_matches
    nth_match = points_and_scores(n, :);
    x =  nth_match(1, 1);
    y =  nth_match(1, 2);
    patch = search_img(y:y+t_height-1, x:x+t_width-1, :);
    patches(:,:,:, i) = patch;
    scores(i) = nth_match(1, 3);
    i = i+1;
end
for n=1:size(closest_matches, 2)
    figure;imagesc(patches(:, :, :, n)/255); title(sprintf('%d closest match, SSD score: %g', closest_matches(n), scores(n)));save_current_frame(fullfile('out', sprintf('ssd-%d-closest-match.png', closest_matches(n))));
end
figure;plot(points_and_scores(:, 3));xlabel('k');ylabel('SSD');title('SSD score for kth closest match');save_current_frame(fullfile('out', 'ssd-plot.png'));
pause;
close all;

% Problem 1 - NCC
i = 1;
[ncc, points_and_scores] = ncc_template_matching(search_img, template);
for n=closest_matches
    nth_match = points_and_scores(n, :);
    x =  nth_match(1, 1);
    y =  nth_match(1, 2);
    patch = search_img(y:y+t_height-1, x:x+t_width-1, :);
    patches(:,:,:, i) = patch;
    scores(i) = nth_match(1, 3);
    i = i+1;
end
for n=1:size(closest_matches, 2)
    figure;imagesc(patches(:, :, :, n)/255); title(sprintf('%d closest match, NCC score: %g', closest_matches(n), scores(n)));save_current_frame(fullfile('out', sprintf('ncc-%d-closest-match.png', closest_matches(n))));
end
figure;plot(points_and_scores(:, 3));xlabel('k');ylabel('SSD');title('NCC score for kth closest match');save_current_frame(fullfile('out', 'ncc-plot.png'));
pause;
close all;


% Problem 2 - disparity map
clear; close all; clc;
left_image = double(imread('input\left.png'));
right_image = double(imread('input\right.png'));
disp('Computing disparity map');
disp('Now we wait...');
disp_map = disparity_map(left_image, right_image, 11, 11);
figure;imagesc(disp_map, [0 50]); axis equal;colormap gray; title('Disparity map'); save_current_frame(fullfile('out', 'disparity_map.png'));
pause;

% Problem 3 - classification
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