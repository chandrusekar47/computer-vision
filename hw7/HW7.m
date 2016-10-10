% Problem 1
clc;clear;close all;
img = double(imread('input\checker.png'));
[height, width] = size(img);
sigma_d = 0.7;
sigma_i = 1;
trace_weight = 0.05;
[Gx, Gy] = gaussDeriv2D(sigma_d);
Ix = imfilter(img, Gx, 'replicate');
Iy = imfilter(img, Gy, 'replicate');
g_Ix2 = gauss(Ix.^2, sigma_i);
g_Iy2 = gauss(Iy.^2, sigma_i);
g_IxIy = gauss(Ix.*Iy, sigma_i);
R = g_Ix2 .* g_Iy2 - g_IxIy.^2 - trace_weight .* ((g_Ix2 + g_Iy2).^2);
R(R < 1e6) = 0;
imagesc(R);
pause;
new_image = non_maximal_supression(R);
[y, x] = find(new_image > 0);
imagesc(img);
colormap('gray');
hold on;
plot(x, y, 'b+', 'MarkerSize', 5);
plot(x, y, 'yo', 'MarkerSize', 5);
hold off;
pause;

% Problem 2
clc;clear;close all;
img = double(imread('input\tower.png'));
thresholds = [20 30 50];
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