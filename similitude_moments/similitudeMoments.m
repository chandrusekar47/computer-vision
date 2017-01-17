function [N] = similitudeMoments(boxImg)
    [centroidX, centroidY] = computeCentroid(boxImg);
    momentsToConsider = [ 0 2; 0 3; 1 1; 1 2; 2 0; 2 1; 3 0];
    zeroOrderMoment = computeMoment(boxImg, centroidX, centroidY, 0, 0);
    N = zeros (1, size(momentsToConsider, 1));
    for row = 1:size(momentsToConsider, 1)
        p = momentsToConsider(row, 1);
        q = momentsToConsider(row, 2);
        momentValue = computeMoment(boxImg, centroidX, centroidY, p ,q);
        N(1, row) = momentValue / (zeroOrderMoment^(((p+q)/2) + 1));
    end
end