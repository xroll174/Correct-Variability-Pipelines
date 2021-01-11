function [] = false_positive_rate_octave_full_hand_size_corr_fsl(smooth1,smooth2,reg1,reg2,der1,der2,size,corr)
    smooth1 = num2str(smooth1);
    smooth2 = num2str(smooth2);
    reg1 = num2str(reg1);
    reg2 = num2str(reg2);
    der1 = num2str(der1);
    der2 = num2str(der2);
    
    if corr==0
        for i=1:1000
            false_positive_rate_octave(smooth1,smooth2,reg1,reg2,der1,der2,['SLA',num2str(i),'_',num2str(size),'_hand_FSL'])
        end

        Lfract=[]
        Lmean = []
		
	for i=1:1000
	    a = load(fullfile('data',['SLA',num2str(i),'_',num2str(size),'_hand_FSL'],['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'FPR.mat'))
	    Lfract=[Lfract,a.fract]
	    Lmean = [Lmean,mean(Lfract)]
	end
		
        mean=Lmean(1000)

        mkdir_mult(fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2]))
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lfract_hand_',num2str(size),'_FSL.mat']),'Lfract')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lmean_hand_',num2str(size),'_FSL.mat']),'Lmean')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['mean_hand_',num2str(size),'_FSL.mat']),'mean')
    else
        for i=1:1000
            false_positive_rate_octave_corr(smooth1,smooth2,reg1,reg2,der1,der2,['SLA',num2str(i),'_',num2str(size),'_hand_FSL'])
        end
        
        Lfract=[]
        Lmean = []

	for i=1:1000
	    a = load(fullfile('data',['SLA',num2str(i),'_',num2str(size),'_hand_FSL'],['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'FPR_FWE.mat'))
	    Lfract=[Lfract,((a.fract)>0)*1]
	    Lmean = [Lmean,mean(Lfract)]
	end
        mean=Lmean(1000)

        mkdir_mult(fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2]))
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lfract_hand_',num2str(size),'_FWE_FSL.mat']),'Lfract')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lmean_hand_',num2str(size),'_FWE_FSL.mat']),'Lmean')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['mean_hand_',num2str(size),'_FWE_FSL.mat']),'mean')
    end
end
