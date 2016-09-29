mkdir 'out';
% Problem 1
clear; close all;
num_of_images = 22;
img_width = 240;
img_height = 320;
Images = zeros(img_height, img_width, num_of_images);
base_differences = zeros(img_height, img_width, num_of_images-1);
thresh_differences = zeros(img_height, img_width, num_of_images-1);
for n=1:num_of_images
    Images (:, :, n) = medfilt2(double(imread(fullfile('input',sprintf('aerobic-%03d.bmp',n)))));
    if n > 1
        base_differences(:, :, n-1) = abs(Images(:, :, n) - Images(:, :, n-1));
    end
end
% cycle between various thresholds
for thresh=1:2:15
    for n=1:(num_of_images-1)
        imagesc(imdilate(bwareaopen(base_differences(:, :, n) > thresh, 5), strel('disk', 1)));
        title(sprintf('Threshold: %d, Difference between %d and %d', thresh, n, n+1));
        pause(0.01);
    end
    pause(0.1);
end

good_threshold = 10;
for n=1:size(base_differences,3)
    thresh_differences(:,:,n) = imdilate(bwareaopen(base_differences(:, :, n) > good_threshold, 5), strel('disk', 1));
    imagesc(thresh_differences(:,:,n));
    title(sprintf('Threshold: %d, Difference between %d and %d', good_threshold, n, n+1));
    pause(0.01);
end
pause;

% Problem 2
motion_history=zeros(img_height, img_width, num_of_images - 1);
duration = num_of_images - 1; % same as the number of difference images.
for frame_number=1:duration
    % H(x, y, t) = duration if D(x,y,t) = 1
    current_frame_history = thresh_differences(:, :, frame_number) .* duration;
    if frame_number > 1 
        for row=1:size(current_frame_history, 1)
            for col=1:size(current_frame_history, 2)
                if current_frame_history(row, col) == 0
                    % H(x,y,t) = max(0, H(x,y,t-1) - 1) if D(x,y,t) = 0
                    current_frame_history(row, col) = max(0, motion_history(row, col, frame_number - 1) - 1);
                end
            end
        end
    end
    motion_history(:, :, frame_number) = current_frame_history;
end
% normalizing the motion_history_image
motion_history_image = motion_history(:, :, duration)./duration;
% thresholding mhi to get mhe
motion_energy_image = motion_history_image > 0;
imagesc(motion_energy_image);
title('Motion enery image');
colormap('gray');
save_current_frame(fullfile('out', 'motion_energy_image.bmp'));
pause;
imagesc(motion_history_image);
title('Motion history image');
colormap('gray');
save_current_frame(fullfile('out', 'motion_history_image.bmp'));
pause;

mei_sim_moments = similitudeMoments(motion_energy_image);
disp(mei_sim_moments);
mhi_sim_moments = similitudeMoments(motion_history_image);
disp(mhi_sim_moments);

% Problem 3
base_image = zeros(101, 101);
base_image(41:61, 41:61) = ones(21, 21);
shifted_image = zeros(101, 101);
shifted_image(42:62, 42:62) = ones(21, 21);
% fx fy gradient filters assuming the top left corner is origin and y is
% +ve as we go down from top left to bottom left
fx_filter = [-1 0 1; -2 0 2; -1 0 1]./8;
fy_filter = [-1 -2 -1; 0 0 0; 1 2 1]./8;

ft = shifted_image - base_image;
fx = imfilter(shifted_image, fx_filter, 'replicate');
fy = imfilter(shifted_image, fy_filter, 'replicate');
imagesc(fx);
title('After applying fx filter');
pause;
imagesc(fy);
title('After applying fy filter');
pause;
normal_flow_vectors = zeros(2, 101);
normal_flow_start_points = zeros(2, 101);
number_of_vectors = 0;
for x=1:size(fx,2)
    for y=1:size(fx,1)
        if fx(y,x) == 0 && fy(y,x) == 0
            continue
        end
        number_of_vectors = number_of_vectors + 1;
        c = sqrt(fx(y,x)^2 + fy(y,x)^2);
        magnitude = -ft(y,x) ./ c;
        normal_flow_vectors(1, number_of_vectors) = magnitude * fx(y,x) ./ c;
        normal_flow_vectors(2, number_of_vectors) = magnitude * fy(y,x) ./ c;
        normal_flow_start_points(1,number_of_vectors) = x;
        normal_flow_start_points(2,number_of_vectors) = y;
    end
end
imagesc(base_image);
hold on;
quiver(normal_flow_start_points(1, :), normal_flow_start_points(2, :), normal_flow_vectors(1, :), normal_flow_vectors(2, :));
% changing axis of the plot so that origin is at top-left
title('Normal flow vectors');
axis('ij');
hold off;