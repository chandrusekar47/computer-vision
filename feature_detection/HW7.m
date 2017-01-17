mkdir 'out';
% Problem 1
clc;clear;close all;
img = double(imread('input\checker.png'));
[height, width] = size(img);
sigma_d = 0.7;
sigma_i = 1;
trace_weight = 0.05;
[points, R] = harris_detector(img, sigma_d, sigma_i, trace_weight);
imagesc(R);
title('Harris detector - before non maximum supression');
save_current_frame(fullfile('out','before_max_supression.png'));
pause;
imagesc(img);
colormap('gray');
hold on;
plot(points(:, 1), points(:, 2), 'b+', 'MarkerSize', 5);
plot(points(:, 1), points(:, 2), 'yo', 'MarkerSize', 5);
hold off;
title(sprintf('Harris detector - after non maximum supression\nNumber of interest points: %d', size(points, 1)));
save_current_frame(fullfile('out','after_max_supression.png'));
pause;

% Problem 2
clc;clear;close all;
img = double(imread('input\tower.png'));
thresholds = [10 20 30 50];
n_star = 9;
for threshold=thresholds
    points = fast_detector(img, threshold, n_star);
    imagesc(img);
    colormap('gray');
    hold on;
    plot(points(:, 1), points(:, 2), 'rx');
    hold off;
    title(sprintf('FAST detector - threshold %d\nNumber of interest points: %d', threshold, size(points, 1)));
    pause(2);
    save_current_frame(fullfile('out',sprintf('fast-detector-%d.png', threshold)));
end