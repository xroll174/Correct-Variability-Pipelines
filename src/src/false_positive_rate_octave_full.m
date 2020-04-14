function [] = false_positive_rate_octave_full(smooth1,smooth2,reg1,reg2,der1,der2)
    smooth1 = num2str(smooth1);
    smooth2 = num2str(smooth2);
    reg1 = num2str(reg1);
    reg2 = num2str(reg2);
    der1 = num2str(der1);
    der2 = num2str(der2);
    for i=1:1000
        false_positive_rate_octave(smooth1,smooth2,reg1,reg2,der1,der2,['SLA',num2str(i),'_50'])
    end
    
    Lfract=[]
    Lmean = []
    for i=1:1000
        a = load(fullfile('data',['SLA',num2str(i),'_50'],['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'FPR.mat'))
        Lfract=[Lfract,a.fract]
        Lmean = [Lmean,mean(Lfract)]
    end
    mean=Lmean(1000)
    
    mkdir_mult(fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2]))
    save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],'Lfract.mat'),'Lfract')
    save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],'Lmean.mat'),'Lmean')
    save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],'mean.mat'),'mean')
end