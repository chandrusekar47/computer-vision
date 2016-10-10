function [out] = gauss(img, sigma) 
    gauss_filter = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
    out = imfilter(img, gauss_filter, 'replicate');
end