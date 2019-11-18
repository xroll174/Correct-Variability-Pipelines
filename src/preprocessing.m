function [] = preprocessing(subject,smooth_value)

    % We carry out the preprocessing of the raw data with SPM. The .zip
    % archive files for the functional and structural data have to be
    % downloaded from the HCP website prior to the execution of the
    % proprecessing. the subject variable is the 6-digit subject id and the
    % smooth_value variable is the FWHM value for smoothing (equal to 5 or
    % 8). They can be entered as integer, string or character.
    
    % The fully preprocessed data file, as well as intermediate files
    % (realigned, normalized) are present in the same directory as the
    % original unprocessed functional data
    % ({subject}/unprocessed/3T/tfMRI_MOTOR_LR})

    
    
    data_path = fileparts(mfilename('fullpath'));
    if isempty(data_path), data_path = pwd; end    
    
    % name of the directory is stored in data_path

    
    spm('Defaults','fMRI');
    spm_jobman('initcfg');

    clear matlabbatch;
    
    
    
    
    % subject and smooth_value are converted to char

    subject = char(string(subject));
    smooth_value = char(string(smooth_value));
    
    
    
    
    % The structural and functional files are unzipped if it has not been
    % done already, i.e. if the following files or directories do not exist
    % yet

    if not(isdir(fullfile('data',subject,'unprocessed','3T','T1w_MPR1')))
        unzip(fullfile('data',[subject,'_3T_Structural_unproc.zip']));
    end    

    if not(isfile(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_T1w_MPR1.nii'])))
        gunzip(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_T1w_MPR1.nii.gz']));
    end
 
    if not(isdir(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR')))
        unzip(fullfile('data',[subject,'_3T_tfMRI_MOTOR_unproc.zip']));
    end    

    if not(isfile(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_tfMRI_MOTOR_LR.nii'])))
        gunzip(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_tfMRI_MOTOR_LR.nii.gz']));
    end
    
        
    
    % We store the full path names of the functional and structural data in
    % variables f and a
    
    f = spm_select('FPList', fullfile(data_path,'data',subject,'unprocessed','3T','tfMRI_MOTOR_LR'),['^',subject,'_3T_tfMRI_MOTOR_LR.nii$']);
    a = spm_select('FPList', fullfile(data_path,'data',subject,'unprocessed','3T','T1w_MPR1',['^',subject,'_3T_T1w_MPR1.nii$']));
    
    
    
    
    % We realign the functional data if it has not been done already

    if not(isfile(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['r',subject,'_3T_tfMRI_MOTOR_LR.nii'])))
        matlabbatch{1}.spm.spatial.realign.estwrite.data{1} = cellstr(f);
        spm_jobman('run',matlabbatch);
        clear matlabbatch;
    end
    
    % The motion regressors for the first-level analysis are stored in a
    % file rp_{subject}.txt. We build the 24-regressor file
    % rp24_{subject}.txt which also contains the derivatives, squares and
    % squares of derivatives of the initial motion regressors, thanks to a
    % bash script, mp_diffpow24.sh
    
    system(['bash mp_diffpow24.sh ',fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['rp_',subject,'_3T_tfMRI_MOTOR_LR.txt']),' ',fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['rp24_',subject,'_3T_tfMRI_MOTOR_LR.txt'])]);
    
    
    
    % We perform the normalization of the realigned data if it has not been
    % done already
        
    if not(isfile(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['wr',subject,'_3T_tfMRI_MOTOR_LR.nii'])))
        matlabbatch{1}.spm.spatial.coreg.estimate.ref    = cellstr(spm_file(f,'prefix','mean'));
        matlabbatch{1}.spm.spatial.coreg.estimate.source = cellstr(a);

        matlabbatch{2}.spm.spatial.preproc.channel.vols  = cellstr(a);
        matlabbatch{2}.spm.spatial.preproc.channel.write = [0 1];
        matlabbatch{2}.spm.spatial.preproc.warp.write    = [0 1];

        defo = cellstr(spm_file(a,'prefix','y_','ext','nii'));

        matlabbatch{3}.spm.spatial.normalise.write.subj.def      = cellstr(defo);
        matlabbatch{3}.spm.spatial.normalise.write.subj.resample = cellstr(char(spm_file(f,'prefix','r'),spm_file(f,'prefix','mean')));
        matlabbatch{3}.spm.spatial.normalise.write.woptions.vox  = [3 3 3];

        matlabbatch{4}.spm.spatial.normalise.write.subj.def      = cellstr(defo);
        matlabbatch{4}.spm.spatial.normalise.write.subj.resample = cellstr(char(spm_file(a,'prefix','m','ext','nii')));
        matlabbatch{4}.spm.spatial.normalise.write.woptions.vox  = [1 1 1.5];

        spm_jobman('run',matlabbatch);
        clear matlabbatch;    
    end
    
    
    
    
    % We carry out the smoothing of the normalized data if it has not been
    % done already. The full preprocessed sequence is then stored in the
    % file with the prefix sXwr, with X being equal to the smoothing
    % parameter entered as input
    
    if smooth_value == '8'
        if not(isfile(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['s8wr',subject,'_3T_tfMRI_MOTOR_LR.nii'])))            
            matlabbatch{1}.spm.spatial.smooth.data = cellstr(spm_file(f,'prefix','wr'));
            matlabbatch{1}.spm.spatial.smooth.fwhm = [8 8 8];
            matlabbatch{1}.spm.spatial.smooth.prefix = 's8';
            spm_jobman('run',matlabbatch);
            clear matlabbatch;    
        end
    elseif smooth_value == '5'
        if not(isfile(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['s5wr',subject,'_3T_tfMRI_MOTOR_LR.nii'])))            
            matlabbatch{1}.spm.spatial.smooth.data = cellstr(spm_file(f,'prefix','wr'));
            matlabbatch{1}.spm.spatial.smooth.fwhm = [5 5 5];
            matlabbatch{1}.spm.spatial.smooth.prefix = 's5';
            spm_jobman('run',matlabbatch);
            clear matlabbatch;    
        end    
    end
    
    
    
    % Once the files have been created, we delete the .zip archives as well
    % as the useless files and directories which are contained in the
    % unzipped directories
    
    clean(subject)
    
end
