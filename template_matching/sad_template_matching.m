function [sad, point_and_sad_scores] = sad_template_matching(search_img, template)
    [t_height, t_width, ~] = size(template);
    t_half_width = floor(t_width/2);
    t_half_height = floor(t_height/2);
    t_center_x = ceil(t_width/2);
    t_center_y = ceil(t_height/2);
    [s_height, s_width, ~] = size(search_img);
    sad = zeros(s_height, s_width);

    for x=t_center_x:(s_width-t_half_width)
        for y=t_center_y:(s_height-t_half_height)
            sad(y,x) = sum(sum(sum(abs(search_img(y-t_half_height:y+t_half_height, x-t_half_width:x+t_half_width, :) - template))));
        end
    end
    sad_excluding_borders = sad(t_center_y:(s_height-t_half_height), t_center_x:(s_width-t_half_width));
    [sorted_values, sorted_index] = sort(sad_excluding_borders(:));
    [y, x] = ind2sub(size(sad_excluding_borders), sorted_index);
    point_and_sad_scores = [x y sorted_values];
end