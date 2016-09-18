function [reduced_image] = reduce_gaussian (img) 
    gauss_filt = apply_separable_gaussian_filter(img, 0.4);
    dim = size(img);
    reduced_image = gauss_filt(1:2:dim(1), 1:2:dim(2));
end