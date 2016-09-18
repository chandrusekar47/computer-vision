function [expanded_image] = expand_image(image_so_far, next_level)
    expanded_image = next_level + imresize(image_so_far, 'bilinear', 'OutputSize', size(next_level), 'Antialiasing', false, 'Dither', false, 'Colormap', 'original');
end