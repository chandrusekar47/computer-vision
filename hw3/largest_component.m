function [LargestComponentBinary, LargestComponentOrig] = largest_component () 
    orig_img = read_indexed_bmp('images\\walk.bmp');
    dilated_img = dilate(orig_img);
    [Label_img, num] = bwlabel(dilated_img, 8);
    num_of_hist_bins = num + 1; 
%   get the frequency of each label in the labelled image.
    hist_counts = histcounts(Label_img, 1:num_of_hist_bins);
%   the most frequent label represents the largest component in the image
    most_frequent_label = find(hist_counts ==  max(hist_counts));
%   get the rows and columns containing the most frequent label
    [r,c] = find(Label_img == most_frequent_label);
    LargestComponentBinary = Label_img(min(r):max(r), min(c):max(c));
    LargestComponentOrig = orig_img(min(r):max(r), min(c):max(c));
end