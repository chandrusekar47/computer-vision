function [area] = computeArea (image) 
    image = double(image);
    allAreas = table2array(regionprops('table', image, 'Area'));
    nonZeroAreaIndexes = find(allAreas > 0);
    if(isempty(nonZeroAreaIndexes))
        area = 0;
    else
        area = allAreas(nonZeroAreaIndexes(1, 1));
    end
end