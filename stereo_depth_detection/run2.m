clc;clear;close all;

left_img = double(imread('input/moto_camera_frames/moto_camera_00001.png'));
right_img = double(imread('input/nexus_camera_frames/nexus_camera_00001.png'));
left_img_points = [362.6324 181.6029 ; 501.1618 184.2500 ; 576.1618 157.3382 ; 379.3971 36.0147 ; 421.3088 84.9853 ; 323.8088 142.3382 ; 188.3676 138.8088 ; 10.1324 130.8676 ];
right_img_points = [389.1029 184.6912; 515.2794 184.6912; 591.6029 158.6618; 409.8382 56.7500; 458.8088 96.8971; 361.7500 150.2794; 242.1912 148.0735; 89.1029 144.5441];
fundamental_matrix = compute_fundamental_matrix(left_img_points, right_img_points);
figure;imagesc(left_img/255);axis('image');
[x, y] = ginput(1);
template_width = 21;
template_height = 40;
[match_x, match_y, points_on_line] = find_corresponding_point(x, y, left_img, right_img, fundamental_matrix, 21, 40);

figure;imagesc(right_img/255);axis('image');hold on;plot(points_on_line(:, 1), points_on_line(:, 2), 'b+');hold off;
pause;
close all;
figure; imagesc(left_img/255); axis('image'); hold on; rectangle('Position', [x-template_width/2 y-template_height/2 template_width template_height]); hold off;
figure; imagesc(right_img/255); title('matching point'); axis('image');hold on; rectangle('Position', [match_x-template_width/2 match_y-template_height/2 template_width template_height]);hold off;