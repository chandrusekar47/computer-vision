function [] = rgb_bmp2jpg()
%rgb_bmp2jpb converts the rgb bmp image to a jpg image
rgbIm = imread('buckeyes_rgb.bmp');
imagesc(rgbIm);
axis('image');
%imwrite(rgbIm, 'buckeyes_rgb.jpg');
end

