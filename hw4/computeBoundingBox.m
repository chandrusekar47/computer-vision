function [topLeftX, topLeftY, length, height] = computeBoundingBox (image) 
    image = double(image);
    tableOut = regionprops('table', image, 'BoundingBox');
    uniqueEntries = table2array(unique(tableOut));
    firstNonZeroBoundingBox = zeros(1, 4);
    for row=1:size(uniqueEntries, 1)
        if(uniqueEntries(row, 3) > 0 && uniqueEntries(row, 4) > 0)
            firstNonZeroBoundingBox(1, :) = uniqueEntries(row, :);
            break;
        end
    end
    topLeftX = firstNonZeroBoundingBox(1, 1);
    topLeftY = firstNonZeroBoundingBox(1, 2);
    length = firstNonZeroBoundingBox(1, 3);
    height = firstNonZeroBoundingBox(1, 4);
end