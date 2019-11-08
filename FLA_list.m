function [] = FLA_list(list_subjects,smooth,reg,der)
    parfor i=1:length(list_subjects)
        first_level_analysis(list_subjects(i),smooth,reg,der)
end