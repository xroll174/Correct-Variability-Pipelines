function [] = second_level_analysis_octave_hand_corr_mixed_cov(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,folder,corr)
    
    % A group analysis is performed for two groups of subjects
    % which have been preprocessed and analyzed at the first level for a
    % specific pipeline each.
    
    % We specify two list of subject id, as well as parameter values
    % for smoothing (5, 8), number of regressors (0, 6, 24) and absence or
    % presence of temporal derivatives (0, 1) for both groups of subjects :
    % smooth1, reg1, der1 for the first group and the others for the second
    % group. We also specify the name of the folder in which the second-level
    % analysis files will be saved.
    
    % The subjects which are specified in both groups must already have been
    % preprocessed and analyzed at the first-level for the parameters
    % given as input for each group
    
    data_path = pwd;
    smooth1 = num2str(smooth1);
    smooth2 = num2str(smooth2);
    reg1 = num2str(reg1);
    reg2 = num2str(reg2);
    der1 = num2str(der1);
    der2 = num2str(der2);
    folder = num2str(folder);

    if corr==0
       filename='spmT_0001_thresholded.nii'
       filename2='spmT_0002_thresholded.nii'
      else
	filename='spmT_0001_thresholded_FWE.nii'
	filename2='spmT_0002_thresholded_FWE.nii'
    end

    printf(filename)
    printf(filename2)

    a1=exist(fullfile('data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],filename))
    a2=exist(fullfile('data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],filename2))
    
    if not(a1 & a2)
      if not(exist(fullfile('data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat')))
        L1 = [];
        for i = 1:(length(list_1)/2)
            L1 = [L1;fullfile(data_path,'data',num2str(list_1(i)),'analysis',['smooth_',smooth1],['reg_',reg1],['der_',der1],'con_0002.nii,1')];
        end    
        for i = (length(list_1)/2+1):length(list_1)
            L1 = [L1;fullfile(data_path,'data',num2str(list_1(i)),'analysis',['smooth_',smooth2],['reg_',reg2],['der_',der2],'con_0002.nii,1')];
        end    

        L2 = [];
        for i = 1:(length(list_2)/2)
            L2 = [L2;fullfile(data_path,'data',num2str(list_2(i)),'analysis',['smooth_',smooth1],['reg_',reg1],['der_',der1],'con_0002.nii,1')];
        end    
        for i = (length(list_2)/2+1):length(list_2)
            L2 = [L2;fullfile(data_path,'data',num2str(list_2(i)),'analysis',['smooth_',smooth2],['reg_',reg2],['der_',der2],'con_0002.nii,1')];
        end
        
        Lcov0 = zeros(1,25)
        Lcov1=ones(1,25)
        Lcov=[Lcov0,Lcov1,Lcov0,Lcov1]

        % The files for the second level analysis are stored in the folder
        % data/{folder}/smooth_i1_i2/reg_j1_j2/der_k1_k2, with {folder} being
        % the folder name given as input and i1,...,k2 the values entered for
        % the parameters for both groups

        mkdir_mult(fullfile('data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2]));
        matlabbatch{1}.spm.stats.factorial_design.dir = {fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2])};

        matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = cellstr(L1);
        matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = cellstr(L2);

        matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
        %%
        matlabbatch{1}.spm.stats.factorial_design.cov.c = Lcov;

        %%
        matlabbatch{1}.spm.stats.factorial_design.cov.cname = 'pipelinediff';
        matlabbatch{1}.spm.stats.factorial_design.cov.iCFI = 1;
        matlabbatch{1}.spm.stats.factorial_design.cov.iCC = 1;

        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

        matlabbatch{2}.spm.stats.fmri_est.spmmat = {fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat')};
        matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
        matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

        spm_jobman('run',matlabbatch);
        clear matlabbatch;

      end

      load(fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat'));
      SPM.xCon=[];
      save(fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat'),'SPM');
      
      matlabbatch{1}.spm.stats.con.spmmat = {fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat')};
      matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'Diff';
      matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
      matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
      matlabbatch{1}.spm.stats.con.delete = 0;

      matlabbatch{1}.spm.stats.con.spmmat = {fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat')};
      matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Diff';
      matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
      matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
      matlabbatch{1}.spm.stats.con.delete = 0;
        
      spm_jobman('run',matlabbatch);
      clear matlabbatch;

        if corr==0
            matlabbatch{1}.spm.stats.results.spmmat = {fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat')};
            matlabbatch{1}.spm.stats.results.conspec.titlestr = '';
            matlabbatch{1}.spm.stats.results.conspec.contrasts = Inf;
            matlabbatch{1}.spm.stats.results.conspec.threshdesc = 'none';
            matlabbatch{1}.spm.stats.results.conspec.thresh = 0.001;
            matlabbatch{1}.spm.stats.results.conspec.extent = 0;
            matlabbatch{1}.spm.stats.results.conspec.conjunction = 1;
            matlabbatch{1}.spm.stats.results.conspec.mask.none = 1;
            matlabbatch{1}.spm.stats.results.units = 1;
            matlabbatch{1}.spm.stats.results.export{1}.tspm.basename = 'thresholded';
        else
            matlabbatch{1}.spm.stats.results.spmmat = {fullfile(data_path,'data',folder,['smooth_',smooth1,'_',smooth2],['reg_',reg1,'_',reg2],['der_',der1,'_',der2],'SPM.mat')};
            matlabbatch{1}.spm.stats.results.conspec.titlestr = '';
            matlabbatch{1}.spm.stats.results.conspec.contrasts = Inf;
            matlabbatch{1}.spm.stats.results.conspec.threshdesc = 'FWE';
            matlabbatch{1}.spm.stats.results.conspec.thresh = 0.05;
            matlabbatch{1}.spm.stats.results.conspec.extent = 0;
            matlabbatch{1}.spm.stats.results.conspec.conjunction = 1;
            matlabbatch{1}.spm.stats.results.conspec.mask.none = 1;
            matlabbatch{1}.spm.stats.results.units = 1;
            matlabbatch{1}.spm.stats.results.export{1}.tspm.basename = 'thresholded_FWE';
        end

        spm_jobman('run',matlabbatch);
        clear matlabbatch;

        cd(data_path);
    end
end
