function [points, R] = harris_detector(img, sigma_d, sigma_i, trace_weight)
    [Gx, Gy] = gaussDeriv2D(sigma_d);
    Ix = imfilter(img, Gx, 'replicate');
    Iy = imfilter(img, Gy, 'replicate');
    g_Ix2 = gauss(Ix.^2, sigma_i);
    g_Iy2 = gauss(Iy.^2, sigma_i);
    g_IxIy = gauss(Ix.*Iy, sigma_i);
    R = g_Ix2 .* g_Iy2 - g_IxIy.^2 - trace_weight .* ((g_Ix2 + g_Iy2).^2);
    R(R < 1e6) = 0;
    new_image = non_maximal_suppression(R);
    [y, x] = find(new_image > 0);
    points = [x y];
end