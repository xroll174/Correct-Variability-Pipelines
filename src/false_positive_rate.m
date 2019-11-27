function [fract] = false_positive_rate(smooth1,smooth2,reg1,reg2,der1,der2,folder)
    data_path = pwd;
    smooth1 = char(string(smooth1));
    smooth2 = char(string(smooth2));
    reg1 = char(string(reg1));
    reg2 = char(string(reg2));
    der1 = char(string(der1));
    der2 = char(string(der2));
    folder = char(string(folder));

    V1 = spm_read_vols(spm_vol(fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'spmT_0001_thresholded.nii'));
    V2 = spm_read_vols(spm_vol(fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'mask.nii'));
    V1 = V1(:)
    V1 = V1(~isnan(V1))
    V2 = V2(:)
    V2 = V2(V2>0))
    fract = sum(V1>0)/length(V2)
end