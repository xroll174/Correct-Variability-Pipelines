function [] = second_level_analysis_octave_mult_hand_size_corr(smooth1,smooth2,reg1,reg2,der1,der2,b1,b2,size,corr)
    G = importdata(['list_couples_subjects_HCP_',num2str(size),'.mat']);
    for i=b1:b2
	    second_level_analysis_octave_hand_corr(G(i,1:size),G(i,(size+1):2*size),smooth1,smooth2,reg1,reg2,der1,der2,['SLA',num2str(i),'_',num2str(size),'_hand'],corr)
    end
end
