function [momentValue] = computeMoment(isSpatial, Img, centroidX, centroidY, momentX, momentY)
    result = 0.0;
    Img = double(Img);
    for x=1:size(Img, 2)
        for y=1:size(Img, 1)
            if isSpatial
                result = result + (((x)^momentX * (y)^momentY)*Img(y, x));
            else
                result = result + (((x-centroidX)^momentX * (y-centroidY)^momentY)*Img(y, x));
            end
        end
    end
    momentValue = result;
end