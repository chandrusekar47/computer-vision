function [dest_x, dest_y, epipolar_points] = find_corresponding_point (center_x, center_y, src_img, target_img, fundamental_matrix, template_width, template_height) 
    [img_height, img_width, ~] = size(target_img);
    epipolar_points = compute_epipolar_line(fundamental_matrix, [center_x center_y], img_width, img_height);
    dest_x = -1;
    dest_y = -1;
    if size(epipolar_points, 1) == 0
        disp('Nothing found');
        return;
    end
    template = src_img(center_y-floor(template_height/2)+1:center_y+ceil(template_height/2), center_x-floor(template_width/2)+1:center_x+ceil(template_width/2), :);
    matching_point = template_match(target_img, template, epipolar_points);
    dest_x = matching_point(1, 1);
    dest_y = matching_point(1, 2);
end