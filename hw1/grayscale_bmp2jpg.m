function [] = grayscale_bmp2jpg()
%bmp2jpg Converts the given grayscale bmp image to jpg
grayIm = imread('buckeyes_gray.bmp');
imagesc(grayIm);
axis('image');
colormap('gray');
%imwrite(grayIm, 'buckeyes_gray_no_scale.jpg');
end