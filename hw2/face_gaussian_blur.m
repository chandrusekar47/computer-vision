function [] = face_gaussian_blur()
    sigma = 40;
    decrement_step =5;
    faceIm = double (imread('face.jpeg'));
    gIm = faceIm;
    while sigma >= 0.5
        G = fspecial ('gaussian', 2 * ceil(3*sigma) + 1, sigma);
        gIm = imfilter(faceIm, G, 'replicate');
        imshow(gIm/255);
        text(10, 20, strcat('Sigma: ', num2str(sigma)), 'Color', 'white', 'FontSize', 14);
        pause;
        if sigma <= decrement_step
            sigma=sigma-0.5;
        else
            sigma=sigma-decrement_step;
        end
    end
end