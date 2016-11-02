function [disp_map] = disparity_map(left_image, right_image, window_width, window_height)
    [height, width] = size(left_image);
    half_width = floor(window_width/2);
    half_height = floor(window_height/2);
    start_x = ceil(window_width/2);
    end_x = width - half_width;
    start_y = ceil(window_height/2);
    end_y = height - half_height;
    disp_map = zeros(height, width);
    for x=start_x:end_x
        for y=start_y:end_y
            template = left_image(y-half_height:y+half_height, x-half_width:x+half_width);
            scan_line = right_image(y-half_height:y+half_height, 1:x+half_width);
            [~, points_and_scores] = ncc_template_matching(scan_line, template);
            match_x = points_and_scores(1, 1) + half_width;
            disp_map(y,x) = (x-match_x);
        end
    end
end