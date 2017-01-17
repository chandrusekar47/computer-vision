image1 = imread('img (1).jpg');
dim = size(image1);
average_filter = fspecial('average', 3);
filteredImage = image1;
for n=1:100
    for i=1:3
        filteredImage(:, :, i) = medfilt2(filteredImage(:, :, i));
    end
end
figure1 = figure();
image(image1);
axis('image');
imwrite(filteredImage, 'median-filterx100.png');
figure2 = figure();
image(filteredImage);
axis('image');