function [centroidx, centroidy] = computeCentroid(image)
    zeroOrderMoment = computeMoment(true, image, NaN, NaN, 0, 0);
    firstOrderXMoment = computeMoment(true, image, NaN, NaN, 1, 0);
    firstOrderYMoment = computeMoment(true, image, NaN, NaN, 0, 1);
    centroidx = firstOrderXMoment/zeroOrderMoment;
    centroidy = firstOrderYMoment/zeroOrderMoment;
end