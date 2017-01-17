function [points] = fast_detector(img, threshold, n_star)
    points_on_circle = [0    -3;
    1    -3;
    2    -2;
    3    -1;
    3     0;
    3     1;
    2     2;
    1     3;
    0     3;
    -1     3;
    -2     2;
    -3     1;
    -3     0;
    -3    -1;
    -2    -2;
    -1    -3];
    points = [];
    [height, width] = size(img);
    radius = 3;
    for x=radius+1:width-radius-1
        for y=radius+1:height-radius-1
            color_values = zeros(1, size(points_on_circle, 1));
            current_pixel_value = img(y,x);
            for n=1:size(points_on_circle,1)
                color_values(1, n) = img(y+points_on_circle(n, 2),x+points_on_circle(n, 1));
            end
            above_values = color_values > current_pixel_value + threshold;
            longest_seq_of_up_values = longest_non_zero_seq(above_values);
            below_values = color_values < current_pixel_value - threshold;
            longest_seq_of_down_values = longest_non_zero_seq(below_values);
            if longest_seq_of_up_values >= n_star || longest_seq_of_down_values >= n_star
                points = cat (1, points, [x y]);
            end
        end
    end
end