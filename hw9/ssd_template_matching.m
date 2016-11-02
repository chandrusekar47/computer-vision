function [ssd, point_and_ssd_scores] = ssd_template_matching(search_img, template)
    [t_height, t_width, ~] = size(template);
    t_half_width = floor(t_width/2);
    t_half_height = floor(t_height/2);
    t_center_x = ceil(t_width/2);
    t_center_y = ceil(t_height/2);
    [s_height, s_width, ~] = size(search_img);
    ssd = zeros(s_height, s_width);

    for x=t_center_x:(s_width-t_half_width)
        for y=t_center_y:(s_height-t_half_height)
            ssd(y,x) = sum(sum(sum((search_img(y-t_half_height:y+t_half_height, x-t_half_width:x+t_half_width, :) - template).^2)));
        end
    end
    ssd_excluding_borders = ssd(t_center_y:(s_height-t_half_height), t_center_x:(s_width-t_half_width));
    [sorted_values, sorted_index] = sort(ssd_excluding_borders(:));
    [y, x] = ind2sub(size(ssd_excluding_borders), sorted_index);
    point_and_ssd_scores = [x y sorted_values];
end