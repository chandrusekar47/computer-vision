% Chandrasekar Swaminathan
% swaminathan.42@osu.edu
% CSE5524 - HW3
% 9/6/2016
mkdir 'out';
% Problem 1
% generating gaussian pyramid 
% 4-Level guassian pyramid, assuming original image is level 1
pyramid_img = generate_gaussian_pyramid(rgb2gray(imread('images\\glados.jpg')), 4);
imagesc(pyramid_img), text(size(pyramid_img, 2) - 180, size(pyramid_img, 1) - 30, '4L Gaussian pyramid', 'Color', 'Yellow', 'BackgroundColor', 'Black', 'EdgeColor', 'White'), axis('image'), colormap('gray');
save_current_frame('out\\gaussian_level4.jpeg');
pause;
% 5-Level guassian pyramid, assuming original image is level 1
pyramid_img = generate_gaussian_pyramid(rgb2gray(imread('images\\glados.jpg')), 5);
imagesc(pyramid_img), text(size(pyramid_img, 2) - 180, size(pyramid_img, 1) - 15, '5L Gaussian pyramid', 'Color', 'Yellow', 'BackgroundColor', 'Black', 'EdgeColor', 'White'), axis('image'), colormap('gray');
save_current_frame('out\\gaussian_level5.jpeg');
pause;

% 4-level laplacian pyramid, assuming original image is level 1
generate_laplacian_pyramid(rgb2gray(imread('images\\glados.jpg')),4);

% expand image
level1 = imread('images\laplacian-error-image-level-1.jpeg');
level2 = imread('images\laplacian-error-image-level-2.jpeg');
level3 = imread('images\laplacian-error-image-level-3.jpeg');
level4 = imread('images\laplacian-image-level-4.jpeg');
image_so_far = expand_image(level4, level3);
image_so_far = expand_image(image_so_far, level2);
image_so_far = expand_image(image_so_far, level1);
imagesc(image_so_far), axis('image'), colormap('gray');
pause;

% Problem 2
background_subtraction_1;

% Problem 3
background_subtraction_2;

% Problem 4
dilated_image = dilate(read_indexed_bmp('images\\walk.bmp'));
imshow(dilated_image);
imwrite(dilated_image, 'out\DilatedImage.jpeg');
pause;

% Problem 5
[binary, gray] = largest_component();
imshow(binary);
pause;
imshow(gray);
imwrite(binary, 'out\LargestBinaryComponent.jpeg');
imwrite(gray, 'out\LargestGrayComponent.jpeg');