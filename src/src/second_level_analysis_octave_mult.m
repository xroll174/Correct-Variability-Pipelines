function [] = second_level_analysis_octave_mult(smooth1,smooth2,reg1,reg2,der1,der2,b1,b2,ng)
    file_name=['list_couples_subjects_HCP_',num2str(ng),'.mat']
    if ~isfile(filename)
        error('Error: list of groups id does not exist')
    else
        G = importdata(filename);
        for i=b1:b2
            second_level_analysis_octave(G(i,1:ng),G50(i,(ng+1):(2*ng)),smooth1,smooth2,reg1,reg2,der1,der2,['SLA',num2str(i),'_',num2str(ng)])
        end
    end
end