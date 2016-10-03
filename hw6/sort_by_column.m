function [sorted_matrix] = sort_by_column (matrix, col_num)
    [~, index_in_matrix] = sort(matrix(:, col_num));
    sorted_matrix = matrix(index_in_matrix, :);
end