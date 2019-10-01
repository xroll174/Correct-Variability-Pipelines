function [] = first_level_analysis(sujet,smooth)

    data_path = fileparts(mfilename('fullpath'));
    if isempty(data_path), data_path = pwd; end   

    spm('Defaults','fMRI');
    spm_jobman('initcfg');
    
    sujet = char(string(sujet));
    smooth = char(string(smooth))
    f = spm_select('FPList', fullfile(data_path,sujet,'unprocessed/3T/tfMRI_MOTOR_LR'), strcat('^',sujet,'_3T_tfMRI_MOTOR_LR.nii$'));

    clear matlabbatch

    onsets    = load(fullfile(data_path,'ev.mat'));
    condnames = {'lf' 'lh' 'rf' 'rh','t'};

    matlabbatch{1}.spm.stats.fmri_spec.dir = {strcat(data_path,'/',sujet,'/analysis_smooth_',smooth)};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 0.753521126760563;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
    matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {strcat(data_path,'/',sujet,'/unprocessed/3T/tfMRI_MOTOR_LR/rp_',sujet,'_3T_tfMRI_MOTOR_LR.txt')};
    matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
    
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess.scans = cellstr(spm_file(f,'prefix',strcat('s',smooth,'wr')));

    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'lf';
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = [26.136
                                                             116.765];
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = 12;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'lh';
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = [71.517
                                                             162.013];
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = 12;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).name = 'rf';
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).onset = [56.39
                                                             177.14];
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).duration = 12;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).orth = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).name = 'rh';
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).onset = [11.009
                                                             131.892];
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).duration = 12;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).orth = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).name = 't';
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).onset = [41.263
                                                             101.638];
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).duration = 12;
   
    
    matlabbatch{2}.spm.stats.fmri_est.spmmat = cellstr(fullfile(data_path,strcat(sujet,'/analysis_smooth_',smooth),'SPM.mat'));


    spm_jobman('run',matlabbatch);
    clear matlabbatch; 
end