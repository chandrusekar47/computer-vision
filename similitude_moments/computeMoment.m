function [momentValue] = computeMoment(Img, centroidRow, centroidCol, i, j)
    result = 0.0;
    Img = double(Img);
    for p=1:size(Img, 1)
        for q=1:size(Img, 2)
            result = result + (((p-centroidRow)^i * (q-centroidCol)^j)*Img(p,q));
        end
    end
    momentValue = result;
end