function [image] = read_indexed_bmp (image_location) 
    [image, map] = imread(image_location);
    image = rgb2gray(ind2rgb(image, map));
end