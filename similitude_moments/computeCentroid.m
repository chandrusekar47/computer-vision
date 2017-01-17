function [centroidX, centroidY] = computeCentroid(img)
    centroidsTable = regionprops('table', img, 'Centroid');
    centroidsArray = table2array(centroidsTable);
    [rows, cols] = find(~isnan(centroidsArray));
    uniqueRows = unique(rows);
    centroidX = centroidsArray(uniqueRows(1), 1);
    centroidY = centroidsArray(uniqueRows(1), 2);
end