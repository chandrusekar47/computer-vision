function [Dil] = dilate (image)
    mahalanobis_dist = mahalanobis(image);
    thresholded = mahalanobis_dist > (2.85^2);
    Dil = bwmorph(thresholded, 'dilate');
end