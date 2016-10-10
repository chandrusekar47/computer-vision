clc;clear;close all;
img = double(imread('input\tower.png'));
thresholds = [20 30 50 60];
n_star = 9;
for threshold=thresholds
    points = fast_detector(img, threshold, n_star);
    imagesc(img);
    colormap('gray');
    hold on;
    plot(points(:, 1), points(:, 2), 'rx');
    hold off;
    pause(2);
end
