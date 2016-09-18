function [laplacian_error_image, next_level_gaussian] = generate_laplacian_error (image) 
    reduced_image = reduce_gaussian(image);
    approx_image = imresize(reduced_image, 2, 'bilinear', 'OutputSize', size(image), 'Antialiasing', false, 'Dither', false, 'Colormap', 'original');
    laplacian_error_image = image - approx_image;
    next_level_gaussian = reduced_image;
end