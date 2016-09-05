function [] = rgb2grayscale()
rgbIm = imread('buckeyes_rgb.bmp');
grayIm = rgb2gray(rgbIm);
imagesc(grayIm);
axis('image')
colormap('gray');
end

