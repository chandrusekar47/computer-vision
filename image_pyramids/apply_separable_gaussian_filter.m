function [FilteredImage] = apply_separable_gaussian_filter(Image, sigma) 
    size = 2 * ceil(3*sigma) + 1;
    Gx = fspecial('gaussian', [1 size], sigma);
    Gy = fspecial('gaussian', [size 1], sigma);
    FilteredImage = imfilter(imfilter(Image, Gx), Gy, 'replicate');
end