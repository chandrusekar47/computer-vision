function [] = generate_laplacian_pyramid (image, levels) 
    next_level_gaussian_image = image;
    for n=1:levels-1
        [laplacian_error_image, next_level_gaussian_image] = generate_laplacian_error(next_level_gaussian_image);
        imwrite(laplacian_error_image, sprintf('out\\laplacian-error-image-level-%d.jpeg', n));
        imagesc(laplacian_error_image), axis('image'), colormap('gray');
        pause;
    end
    imwrite(next_level_gaussian_image, sprintf('out\\laplacian-image-level-%d.jpg', levels));
    imagesc(next_level_gaussian_image), axis('image'), colormap('gray');
    pause;
end