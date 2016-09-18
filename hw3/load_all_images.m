function [Img] = load_all_images() 
    Img = zeros(240, 320, 30);
    for n=1:29
        Img(:,:,n) = read_indexed_bmp(sprintf('images\\bg%03d.bmp', n));
    end
end