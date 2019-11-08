function [rate] = full_analysis(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,dossier)
    A = [list_1,list_2]
    FLA_list(A)
    second_level_analysis(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,dossier)
    rate = false_positive_rate(smooth1,smooth2,reg1,reg2,der1,der2,dossier)
end