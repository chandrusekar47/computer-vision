function [repeated_vector] = repeat_each_element(row_vector, times_to_repeat)
%   eg: row_vector = [1 2 3] & times_to_repeat = 2, output = [1 1 2 2 3 3]
    repeated_rows = repmat(row_vector, times_to_repeat, 1); 
%   repeated_rows = [1 2 3; 1 2 3]
    repeated_vector = repeated_rows(:)';
%   repeated_vector = [1 1 2 2 3 3]
end