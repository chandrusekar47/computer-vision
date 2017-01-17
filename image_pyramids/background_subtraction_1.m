function [] = background_subtraction_1 ()
    background = load_all_images;
    avg_background=mean(background,3);
    image = read_indexed_bmp('images\\walk.bmp');
    for T = 0.0:0.1:0.9
        diff = abs(image-avg_background) > T;
        imshow(diff);
        text(10, 20, sprintf('Threshold : %g', T), 'Color', 'Yellow', 'FontSize', 14, 'EdgeColor', 'white', 'BackgroundColor', 'Black');
        save_current_frame(sprintf('out\\bg-1-%g.jpg', T));
        pause;
    end
    close all;
end