function [] = second_level_analysis_octave_mult(smooth1,smooth2,reg1,reg2,der1,der2,b1,b2)
    G50 = importdata('list_couples_subjects_HCP_50.mat');
    for i=b1:b2
        second_level_analysis_octave(G50(i,1:50),G50(i,51:100),smooth1,smooth2,reg1,reg2,der1,der2,['SLA',num2str(i),'_50'])
    end
end