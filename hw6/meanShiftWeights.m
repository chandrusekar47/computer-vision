function [weights] = meanShiftWeights(feature_matrix, q_model, p_test)
    bins = size(q_model, 1);
    weights = zeros(1, size(feature_matrix, 1));
    for n=1:size(feature_matrix, 1)
        bin_index = floor(feature_matrix(n, 3:5)./ bins) + 1;
        if p_test(bin_index(1), bin_index(2), bin_index(3)) ~= 0
            weights(1, n) = sqrt(q_model(bin_index(1), bin_index(2), bin_index(3))/p_test(bin_index(1), bin_index(2), bin_index(3)));
        end
    end
end