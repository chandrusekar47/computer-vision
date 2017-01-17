function [out] = non_maximal_suppression(img) 
    [height, width] = size(img);
    out = zeros(height, width);
    for x=2:width-1
        for y=2:height-1
            max_in_neighborhood = max(max(img(y-1:y+1, x-1:x+1)));
            if img(y, x) == max_in_neighborhood
                out(y,x) = max_in_neighborhood;
            end
        end
    end
end