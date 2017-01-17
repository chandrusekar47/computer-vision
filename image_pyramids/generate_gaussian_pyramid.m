function [gaussian_pyramid] = generate_gaussian_pyramid(baseImage, levels)
    row_offset = 1;
    col_offset = 1;
    gaussian_pyramid = zeros(floor(size(baseImage,1)/2), floor(size(baseImage,2)/2));
    scaled_down_image=baseImage;
    for n=2:levels
        scaled_down_image = reduce_gaussian(scaled_down_image);
        nrows = size(scaled_down_image,1);
        ncols = size(scaled_down_image,2);
        gaussian_pyramid(row_offset:(nrows+row_offset-1), col_offset:(ncols+col_offset-1)) = scaled_down_image;
        imwrite(scaled_down_image, sprintf('gaussian-pyramid-image-level-%d.png', n)); 
        if n == 2 
            col_offset=col_offset+ncols;
        else
            row_offset=row_offset+nrows;
        end
    end 
end