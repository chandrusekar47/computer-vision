function [score] = sad_score(template, search_region)
    score = sum(sum(sum(abs(search_region - template))));
end