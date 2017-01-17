clc;clear;close all;

left_img = double(imread('input/left_camera_images/left_camera_00001.png'));
right_img = double(imread('input/right_camera_images/right_camera_00001.png'));
left_img_points = [981 799 ;749 752 ;470 381 ;1173 720 ;1001 627 ;655 210 ;609 214 ;788 585];
right_img_points = [1014 816 ; 794 747 ; 623 313 ; 1447 721 ; 1250 601 ; 892 116 ; 846 121 ; 1011 552 ];
fundamental_matrix = compute_fundamental_matrix(left_img_points, right_img_points);
figure;imagesc(left_img/255);axis('image');
[x, y] = ginput(1);
[img_height, img_width, ~] = size(right_img);
close all;
points_on_line = compute_epipolar_line(fundamental_matrix, [x y], img_width, img_height);
if size(points_on_line, 1) == 0
    disp('Nothing found');
else
    figure;imagesc(right_img/255);axis('image');hold on;plot(points_on_line(:, 1), points_on_line(:, 2), 'b+');hold off;
end
pause;

template_width = 21;
template_height = 40;
template = left_img(y-floor(template_height/2)+1:y+ceil(template_height/2), x-floor(template_width/2)+1:x+ceil(template_width/2), :);
size(template)
matching_point = template_match(right_img, template, points_on_line);
figure; imagesc(left_img/255); axis('image'); hold on; rectangle('Position', [x y template_width template_height]); hold off;
figure; imagesc(right_img/255); title('matching_point'); axis('image');hold on; rectangle('Position', [matching_point template_width template_height]);hold off;