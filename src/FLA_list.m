function [] = FLA_list(list_subjects,smooth,reg,der)

    % We perform first level analysis for multiple subjects and for
    % specified parameter values for smoothing, number of regressors and
    % temporal derivatives
    
    parfor i=1:length(list_subjects)
        first_level_analysis(list_subjects(i),smooth,reg,der)
end