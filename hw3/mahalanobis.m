function [Maha] = mahalanobis(image) 
    background = load_all_images;
    avg_background=mean(background,3);
    std_dev_background = std(background, 1, 3);
    Maha = ((image-avg_background)./std_dev_background).^2;
end