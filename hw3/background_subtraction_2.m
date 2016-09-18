function [] = background_subtraction_2 ()
    image = read_indexed_bmp('images\\walk.bmp');
    mahalanobis_dist = mahalanobis(image);
    mkdir('out');
    for T = 0.0:0.1:3.0
        thresholded = mahalanobis_dist > (T^2);
        imshow(thresholded);
        text(10, 20, sprintf('Threshold : %g^2', T), 'Color', 'Yellow', 'FontSize', 14, 'EdgeColor', 'white', 'BackgroundColor', 'Black');
        save_current_frame(sprintf('out\\bg-2-%g.jpg', T));
        pause;
    end
    close all;
end