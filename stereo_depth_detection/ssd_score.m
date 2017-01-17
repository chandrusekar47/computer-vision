function [score] = ssd_score(template, search_region)
    score = sum(sum(sum((search_region - template).^2)));
end