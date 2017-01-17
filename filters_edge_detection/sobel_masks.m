function [] = sobel_masks (Im, T) 
    Fx = -fspecial('sobel')';
    fxIm = imfilter(Im, Fx);
    Fy = -fspecial('sobel');
    fyIm = imfilter(Im, Fy);
    magIm = sqrt(double(fxIm.^2 + fyIm.^2));
    tIm = magIm > T;
    imagesc(tIm);
    colormap('gray');
    axis('image');
end