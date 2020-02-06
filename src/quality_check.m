function [QC] = quality_check(subject,smooth_value,reg,der)

    % storing the thresholded map for a single subject in a
    % 'thresholded.nii' file within the directory
    
    subject = num2str(subject);
    smooth_value = num2str(smooth_value);
    reg = num2str(reg);
    der = num2str(der);
    data_path = pwd;

    S = fullfile(data_path,'data',subject,'analysis',['smooth_',smooth_value],['reg_',reg],['der_',der],'SPM.mat');
    matlabbatch{1}.spm.stats.results.spmmat = {S};
    matlabbatch{1}.spm.stats.results.conspec.titlestr = '';
    matlabbatch{1}.spm.stats.results.conspec.contrasts = Inf;
    matlabbatch{1}.spm.stats.results.conspec.threshdesc = 'FWE';
    matlabbatch{1}.spm.stats.results.conspec.thresh = 0.05;
    matlabbatch{1}.spm.stats.results.conspec.extent = 0;
    matlabbatch{1}.spm.stats.results.conspec.conjunction = 1;
    matlabbatch{1}.spm.stats.results.conspec.mask.none = 1;
    matlabbatch{1}.spm.stats.results.units = 1;
    matlabbatch{1}.spm.stats.results.export{1}.tspm.basename = 'QC_thresholded';
    
    spm_jobman('run',matlabbatch);
    clear matlabbatch;
    
    cd(data_path);

    % looking for any activation in the corresponding zone in the atlas
    % (todo)
    
    V1 = spm_read_vols(spm_vol(fullfile('data',subject,'analysis',['smooth_',smooth_value],['reg_',reg],['der_',der],'spmT_0001_QC_thresholded.nii')));
    V2 = spm_read_vols(spm_vol(fullfile('atlases','HarvardOxford','rHarvardOxford-cort-maxprob-thr25-2mm.nii')));
    
    QC = (sum(V1(:)>0 & V2(:) == 6) > 0);
    
    save(fullfile('data',subject,'analysis',['smooth_',smooth_value],['reg_',reg],['der_',der],'QC.mat'),'QC');
    
end
