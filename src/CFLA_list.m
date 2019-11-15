function [] = CFLA_list(list_subjects)
    parfor i=1:length(list_subjects)
        complete_first_level_analysis(list_subjects(i))
end