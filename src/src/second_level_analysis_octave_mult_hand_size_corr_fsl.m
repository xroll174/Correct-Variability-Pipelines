function [] = second_level_analysis_octave_mult_hand_size_corr_fsl(smooth1,smooth2,reg1,reg2,der1,der2,b1,b2,size,corr)
    file_name=['list_couples_subjects_HCP_',num2str(size),'.mat']
    if ~exist(file_name)
        error('Error: list of groups id does not exist')
    else
        G = importdata(['list_couples_subjects_HCP_',num2str(size),'.mat']);
        for i=b1:b2
	    second_level_analysis_octave_hand_corr_fsl(G(i,1:size),G(i,(size+1):2*size),smooth1,smooth2,reg1,reg2,der1,der2,['SLA',num2str(i),'_',num2str(size),'_hand_FSL'],corr)
        end
    end
end
