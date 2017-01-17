function [score] = ncc_score(template, search_region)
    template_color = template(:, :, j);
    patch_color = patch(:, :, j);
    template_avg = mean(template_color(:));
    patch_avg = mean(patch_color(:));
    ncc(y,x) = ncc(y,x) + sum(sum((patch_color - patch_avg).*(template_color - template_avg)/(std(patch_color(:))*std(template_color(:)))))/(t_height*t_width - 1);
end