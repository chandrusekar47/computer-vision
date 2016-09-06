% Chandrasekar Swaminathan
% swaminathan.42@osu.edu
% CSE5524 - HW2
% 9/6/2016

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1
% applies gaussian filter with sigma values from 40 to 0.5
face_gaussian_blur;
pause;

% Problem 2
% create gaussian second derivative mask with sigma as 0.6 and 2
[Gx, Gy] = gaussDeriv2D(0.6);
[Gx2, Gy2] = gaussDeriv2D(2);
surf(Gx);xlabel('x');ylabel('y');
pause;
imagesc(Gx);
colormap('gray');
pause;
surf(Gy);xlabel('x');ylabel('y');
pause;
imagesc(Gy);
colormap('gray');
pause;
surf(Gx2);xlabel('x');ylabel('y');
pause;
imagesc(Gx2);
colormap('gray');
pause;
surf(Gy2);xlabel('x');ylabel('y');
pause;
imagesc(Gy2);
colormap('gray');
pause;


% Problem 3 
% Computing gradient magnitude
img = imread('rickandmorty.jpg');
img = rgb2gray(img);
gxIm = imfilter(img, Gx, 'replicate');
gyIm = imfilter(img, Gy, 'replicate');
magIm = sqrt(double(gxIm.^2 + gyIm.^2));
imagesc(gxIm);
colormap('gray');
pause;
imagesc(gyIm);
colormap('gray');
pause;
imagesc(magIm);
colormap('gray');
pause;

% Problem 4
% applying a threshold on the gradient magnitude 
T = 0.5;
tIm = magIm > T;
imagesc(tIm); 
pause; % very low threshold
T = 1.5;
tIm = magIm > T;
imagesc(tIm); %slightly better
T = 5;
tIm = magIm > T;
imagesc(tIm); %a lot better


% Problem 5
% Using sobel mask to detect edges
sobel_masks(img, 5);
pause;
sobel_masks(img, 10);
pause;
sobel_masks(img, 15.95);
pause;

% Problem 6
cannyImg = edge(img, 'canny');
imshow(cannyImg);


