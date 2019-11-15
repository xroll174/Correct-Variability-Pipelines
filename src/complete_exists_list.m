function [X] = complete_exists_list(L)
    X = zeros(1,length(L));
    for i = 1:length(L)
        X(i) = complete_exists(L(i));
    end
end