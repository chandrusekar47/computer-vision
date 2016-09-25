% Chandrasekar Swaminathan
% swaminathan.42@osu.edu
% CSE5524 - HW4
% 9/20/2016

% Problem 1
mkdir('output');
image = double(imread(fullfile('input','boxIm1.bmp')));
area = computeArea(image);
[topLeft_X, topLeft_Y, length, height] = computeBoundingBox(image);
[centroidX, centroidY] = computeCentroid(image);
imagesc(image);
colormap('gray');
hold on;
plot(centroidX, centroidY, 'r.');
rectangle ('Position', [topLeft_X topLeft_Y length height], 'EdgeColor', 'r', 'LineWidth', 3);
text(10, 10, sprintf('Area: %g', area), 'Color', 'Yellow', 'BackgroundColor', 'Black', 'EdgeColor', 'White', 'FontSize', 14);
text(centroidX - 10, centroidY + 10, sprintf('Centroid (%g, %g)', centroidX, centroidY), 'EdgeColor', 'White', 'BackgroundColor', 'Black', 'Color', 'Yellow');
save_current_frame(fullfile('output', 'problem1.png'));
hold off;
pause;


% Problem 2
close all; clear;
for n=1:4
    image = double(imread(fullfile('input',sprintf('boxIm%d.bmp', n))));
    simMoments = similitudeMoments(image);
	imagesc(image);
	title(sprintf('boxIm%d.bmp', n));
	colormap('gray');
	text(10, 10, sprintf('Similitude Moments: %s', mat2str(simMoments, 2)), 'Color','Yellow', 'BackgroundColor','Black', 'EdgeColor', 'White');
    pause;
    fprintf('boxIm%d.bmp', n);
    disp(simMoments);
    save_current_frame(fullfile('output', sprintf('similiBoxIm%d.bmp', n)));
end

% Problem 3
clear; close all;
load input\eigdata.txt;
X = eigdata;
subplot(2, 1, 1);
plot(X(:,1), X(:,2), 'b.');
axis('equal');
m = mean(X);
Y = X-ones(size(X,1), 1)*m;
subplot(2,1,2);
plot(Y(:,1), Y(:,2), 'r.');
axis('equal');
pause;

% Problem 4
% the following code assumes that the covariance matrix is 2x2
close all;
covariance = cov(Y);
[eigen_vectors, eigen_values] = eig(covariance);
[eigen_vectors, eigen_values] = sort_descending(eigen_vectors, eigen_values);
C = 9; % (no-of-std-dev)^2
major_axis_length = sqrt(C*eigen_values(1,1));
scaled_major_axis = eigen_vectors(:, 1) * major_axis_length;
minor_axis_length = sqrt(C*eigen_values(2,2));
scaled_minor_axis = eigen_vectors(:, 2) * minor_axis_length;
plot(Y(:, 1), Y(:, 2), 'r.');
hold on;
plot(scaled_major_axis(1,1), scaled_major_axis(2,1), 'b+', 'MarkerSize', 20);
plot(scaled_minor_axis(1,1), scaled_minor_axis(2,1), 'b+', 'MarkerSize', 20);
line([ 0; scaled_major_axis(1,1)], [0; scaled_major_axis(2,1)], 'LineWidth', 5);
line([ 0; scaled_minor_axis(1,1)], [0; scaled_minor_axis(2,1)], 'LineWidth', 5);
save_current_frame(fullfile('output', 'axes.png'));
pause;

% Problem 5
rotated_data = eigen_vectors * Y';
rotated_data = rotated_data';
plot(rotated_data(:, 1), rotated_data(:, 2), 'b+');
axis('equal');
pause;
save_current_frame(fullfile('output', 'rotated-data.png'));

