function [ncc, point_and_ncc_scores] = ncc_template_matching(search_img, template)
    [t_height, t_width, ~] = size(template);
    t_half_width = floor(t_width/2);
    t_half_height = floor(t_height/2);
    t_center_x = ceil(t_width/2);
    t_center_y = ceil(t_height/2);
    [s_height, s_width, ~] = size(search_img);
    ncc = zeros(s_height, s_width);
    for x=t_center_x:(s_width-t_half_width)
        for y=t_center_y:(s_height-t_half_height)
            patch = search_img(y-t_half_height:y+t_half_height, x-t_half_width:x+t_half_width, :);
            for j=1:size(template, 3)
                template_color = template(:, :, j);
                patch_color = patch(:, :, j);
                template_avg = mean(template_color(:));
                patch_avg = mean(patch_color(:));
                ncc(y,x) = ncc(y,x) + sum(sum((patch_color - patch_avg).*(template_color - template_avg)/(std(patch_color(:))*std(template_color(:)))))/(t_height*t_width - 1);
            end
        end
    end
    ncc_excluding_borders = ncc(t_center_y:(s_height-t_half_height), t_center_x:(s_width-t_half_width));
    [sorted_values, sorted_index] = sort(ncc_excluding_borders(:), 'descend');
    [y, x] = ind2sub(size(ncc_excluding_borders), sorted_index);
    point_and_ncc_scores = [x y sorted_values];
end
