function [] = generate_checker_board()
zBlock = zeros(10, 10);
oBlock = ones(10, 10)*255;
pattern = [zBlock oBlock; oBlock zBlock];
checkerImage = repmat(pattern, 5, 5);
imagesc(checkerImage);
%repeat the 2x2 checker board five times both horizontally and vertically.
%checkerImage = repmat(pattern, 5,5);
imwrite(uint8(checkerImage), 'checkerIm.bmp');
imwrite(uint8(checkerImage), 'checkerIm.jpg');
%im = imread('checkerIm.bmp');
%imagesc(pattern);
colormap('gray');
axis('image');
end