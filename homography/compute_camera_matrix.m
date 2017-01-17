function [camera_matrix] = compute_camera_matrix(world_points, camera_points)
    num_points = size(world_points, 1);
    length_of_homo_coords = uint8(size(world_points, 2)+1);
    matrix_a = zeros(2*num_points, (length_of_homo_coords)*3);
    for n=1:2:2*num_points
        world_point = world_points(ceil(n/2), :);
        camera_point = camera_points(ceil(n/2), :);
        matrix_a(n, :) = [world_point 1 zeros(1, length_of_homo_coords) world_point.*-camera_point(1,1) -camera_point(1,1)];
        matrix_a(n+1, :) = [zeros(1, length_of_homo_coords) world_point 1 world_point.*-camera_point(1,2) -camera_point(1,2)];
    end
    [eig_vectors, eig_values] = eig(matrix_a' * matrix_a);
    camera_matrix = reshape(eig_vectors(:, diag(eig_values) ==  min(diag(eig_values))), length_of_homo_coords, 3);
    camera_matrix = camera_matrix';
end