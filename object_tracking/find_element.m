function [row, col] = find_element(A, elem)
    matching_index = find(A==elem);
    col = ceil(matching_index / size(A, 1));
    row = mod(int32(matching_index), size(A, 1));
    if row == 0 
        row = size(A, 1);
    end
end