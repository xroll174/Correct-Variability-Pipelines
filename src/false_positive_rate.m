function [fract,n1,n2] = false_positive_rate(smooth1,smooth2,reg1,reg2,der1,der2,dossier)
    data_path = pwd;
    smooth1 = char(string(smooth1));
    smooth2 = char(string(smooth2));
    reg1 = char(string(reg1));
    reg2 = char(string(reg2));
    der1 = char(string(der1));
    der2 = char(string(der2));
    dossier = char(string(dossier));

    V1 = spm_read_vols(spm_vol([data_path,'/',dossier,'/smooth_',smooth1,'_',smooth2,'/reg_',reg1,'_',reg2,'/der_',der1,'_',der2,'/spmT_0001.nii']));
    V2 = spm_read_vols(spm_vol([data_path,'/',dossier,'/smooth_',smooth1,'_',smooth2,'/reg_',reg1,'_',reg2,'/der_',der1,'_',der2,'/mask.nii']));
    n1 = sum(V1(:) > 1.6716)
    % S'assurer que la stat correspond bien à df = 58
    n2 = sum(V2(:) ~= 0)
    fract = n1/n2
end