function [distance] = covariance_distance(cov_a, cov_b)
    [~, eigen_values, ~] = eig(cov_a, cov_b);
    eigen_values = eigen_values(eigen_values~=0);
    distance = sqrt(sum(log(eigen_values).^2));
end