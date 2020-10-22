function [] = second_level_analysis_octave_mult(smooth1,smooth2,reg1,reg2,der1,der2,b1,b2,ng)
    file_name=['list_couples_subjects_HCP_',num2str(ng),'.mat']
    if ~isfile(filename)
        error('Error: list of groups id does not exist')
      else

          if pipeline_order(smooth1,reg1,der1)<=pipeline_order(smooth2,reg2,der2)
            smooth1_bis=smooth1
            reg1_bis=reg1
            der1_bis=der1
            smooth2_bis=smooth2
            reg2_bis=reg2
            der2_bis=der2
	  else
	    smooth1_bis=smooth2
            reg1_bis=reg2
            der1_bis=der2
            smooth2_bis=smooth1
            reg2_bis=reg1
            der2_bis=der1
          end
        G = importdata(filename);
        for i=b1:b2
            second_level_analysis_octave(G(i,1:ng),G(i,(ng+1):(2*ng)),smooth1_bis,smooth2_bis,reg1_bis,reg2_bis,der1_bis,der2_bis,['SLA',num2str(i),'_',num2str(ng)])
        end
    end
end
