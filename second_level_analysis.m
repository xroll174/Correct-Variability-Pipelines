function [] = second_level_analysis(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,dossier)

    data_path = pwd;
    smooth1 = char(string(smooth1))
    smooth2 = char(string(smooth2))
    reg1 = char(string(reg1))
    reg2 = char(string(reg2))
    der1 = char(string(der1))
    der2 = char(string(der2))
    dossier = char(string(dossier))
    
    L1 = [];
    for i = 1:length(list_1)
        L1 = [L1;[data_path,'/',char(string(list_1(i))),'/analysis/smooth_',smooth1,'/reg_',reg1,'/der_',der1,'/beta_0001.nii,1']]
    end    
    
    L2 = [];
    for i = 1:length(list_2)
        L2 = [L2;[data_path,'/',char(string(list_2(i))),'/analysis/smooth_',smooth2,'/reg_',reg2,'/der_',der2,'/beta_0001.nii,1']]
    end 
    
    matlabbatch{1}.spm.stats.factorial_design.dir = {[data_path,'/',dossier]};
    
    matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = cellstr(L1);
    matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = cellstr(L2);
    
    matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
    
    matlabbatch{2}.spm.stats.fmri_est.spmmat = {[data_path,'/',dossier,'/SPM.mat']};
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

    
    spm_jobman('run',matlabbatch);
    clear matlabbatch; 
end