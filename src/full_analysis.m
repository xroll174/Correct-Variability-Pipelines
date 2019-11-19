function [rate] = full_analysis(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,dossier)

    % for the same input as the second_level_analysis function (couple of
    % groups of subjects and pipeline parameter values, and folder name),
    % we perform preprocessing and first-level analysis for the given
    % parameters on every subject if it has not already been done, and then
    % the second-level analysis between both groups. The function returns
    % the proportion of false positives in the resulting statistical map
    
    A = [list_1,list_2]
    
    FLA_list(A)
    
    second_level_analysis(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,dossier)
    
    rate = false_positive_rate(smooth1,smooth2,reg1,reg2,der1,der2,dossier)
    % (to be modified)
end