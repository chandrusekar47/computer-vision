function [Gx, Gy] = gaussDeriv2D (sigma)
    maskSize = 2*ceil(3*sigma) +1;
    twoSigmaSquared = 2 * sigma^2;
    twoPiSigmaQuad = 2 * pi * sigma^4 ;
    Gx = zeros (maskSize,maskSize);
    Gy = zeros (maskSize,maskSize);
    x0 = floor(maskSize/2) + 1;
    y0 = floor(maskSize/2) + 1;
    for n=1:maskSize
        for m=1:maskSize
            exponentTerm = exp(-((n-x0)*(n-x0) + (m-y0)*(m-y0))/twoSigmaSquared);
            Gx(n,m)= (m-y0) * exponentTerm/twoPiSigmaQuad;
            Gy(n,m)= (n-x0) * exponentTerm/twoPiSigmaQuad;
        end
    end 
end