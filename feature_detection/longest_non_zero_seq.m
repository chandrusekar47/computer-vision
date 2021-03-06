function [longest_seq_length] = longest_non_zero_seq(row_vector)
    number_of_items = size(row_vector, 2);
    seq_length = 0;
    longest_seq_length = 0;
    longest_seq_end_index = 0;
    for n=1:number_of_items
        if row_vector(1, n) == 1
            seq_length = seq_length + 1;
        else
            if seq_length > longest_seq_length
                longest_seq_length = seq_length;
                longest_seq_end_index = n - 1;
            end
            seq_length = 0;
        end
    end
    if seq_length ~= 0
        longest_seq_start_index = number_of_items-seq_length+1;
        longest_seq_end_index = number_of_items;
        longest_seq_length = longest_seq_end_index - longest_seq_start_index + 1;
    end
    if longest_seq_end_index == number_of_items && longest_seq_length ~= number_of_items && row_vector(1,1) == 1
        for n=1:number_of_items
            if row_vector(1, n) == 0
                break;
            end
            longest_seq_length=longest_seq_length+1;
        end
    end
end