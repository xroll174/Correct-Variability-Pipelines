function [W] = complete_exists(sujet)
    list_smooth = [5,8];
    list_reg = [0,6,24];
    list_der = [0,1];
    W = 1;
    for i = 1:length(list_smooth)
        for j = 1:length(list_reg)
            for k = 1:length(list_der)
                W = W & exists(sujet,list_smooth(i),list_reg(j),list_der(k));
            end    
        end
    end    
end