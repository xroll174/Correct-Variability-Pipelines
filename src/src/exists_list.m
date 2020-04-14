function [X] = exists_list(L,smooth,reg,der)
    X = zeros(1,length(L));
    for i = 1:length(L)
        X(i) = complete_exists(L(i),smooth,reg,der);
    end
end