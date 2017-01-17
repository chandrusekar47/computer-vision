function [points_on_epipolar_line] = compute_epipolar_line (fundamental_matrix, point, img2_width, img2_height)
%   point is row vector with x & y coordinate
    corresponding_line = fundamental_matrix * [point 1]';
    [X, Y] = meshgrid(1:img2_width, 1:img2_height);
    equation_values = (corresponding_line(1) * X + corresponding_line(2) * Y) + corresponding_line(3);
    [R, C] = find(equation_values <= 1.0 & equation_values >= 0);
    points_on_epipolar_line = [C R];
end