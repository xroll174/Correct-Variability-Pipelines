function [] = second_level_analysis_octave_mult_hand_soft_size_corr(smooth1,smooth2,reg1,reg2,der1,der2,b1,b2,soft1,soft2,size,corr)
    G = importdata(['list_couples_subjects_HCP_',num2str(size),'.mat']);
    if soft1+soft2==2
        foldername=['SLA',num2str(i),'_',num2str(size),'_hand_FSL']
    elseif soft1+soft2==1
        foldername=['SLA',num2str(i),'_',num2str(size),'_hand_intersoftware']
    else
        foldername=['SLA',num2str(i),'_',num2str(size),'_hand']
    end
    for i=b1:b2
	    second_level_analysis_octave_hand_soft_corr(G(i,1:size),G(i,(size+1):2*size),smooth1,smooth2,reg1,reg2,der1,der2,soft1,soft2,foldername,corr)
    end
end
