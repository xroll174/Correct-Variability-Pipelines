function [] = preprocessing_octave(subject,smooth_value)
  
    % Second version of preprocessing with modifications to make it compatible 
    % with Octave (temporary version)
  
  
  
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

    
    data_path = pwd;
    
    % name of the directory is stored in data_path

    
    spm('Defaults','fMRI');
    spm_jobman('initcfg');

    clear matlabbatch;
    
    
    
    
    % subject and smooth_value are converted to char

    subject = num2str(subject);
    smooth_value = num2str(smooth_value);

     
    if not(isdir(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR')))
        unzip(fullfile('data',[subject,'_3T_tfMRI_MOTOR_unproc.zip']),'data');
    end  
   
    
        
    
    

    
    % We carry out the smoothing of the normalized data if it has not been
    % done already. The full preprocessed sequence is then stored in the
    % file with the prefix sXwr, with X being equal to the smoothing
    % parameter entered as input

    if not(exist(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['s',smooth_value,'wr',subject,'_3T_tfMRI_MOTOR_LR.nii'])))            
        
        % We perform the normalization of the realigned data if it has not been
        % done already
        
        if not(exist(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['wr',subject,'_3T_tfMRI_MOTOR_LR.nii'])))
            
            % We realign the functional data if it has not been done already

            if not(exist(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['r',subject,'_3T_tfMRI_MOTOR_LR.nii'])))
                

                % The structural and functional files are unzipped if it has not been
                % done already, i.e. if the following files or directories do not exist
                % yet

							    
    
                if not(isdir(fullfile('data',subject,'unprocessed','3T','T1w_MPR1')))
                    unzip(fullfile('data',[subject,'_3T_Structural_unproc.zip']),'data');
                end  
                
                if not(exist(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_T1w_MPR1.nii'])))
                    gunzip(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_T1w_MPR1.nii.gz']));
                end

                if not(exist(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_tfMRI_MOTOR_LR.nii'])))
                    gunzip(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_tfMRI_MOTOR_LR.nii.gz']));
                end                   

                % We store the full path names of the functional and structural data in
                % variables f and a

                f = spm_select('FPList', fullfile(data_path,'data',subject,'unprocessed','3T','tfMRI_MOTOR_LR'),['^',subject,'_3T_tfMRI_MOTOR_LR.nii$']);
                a = spm_select('FPList', fullfile(data_path,'data',subject,'unprocessed','3T','T1w_MPR1'),['^',subject,'_3T_T1w_MPR1.nii$']);

                f1 = spm_select('expand',f);
                a1 = spm_select('expand',a);

                matlabbatch{1}.spm.spatial.realign.estwrite.data = {cellstr(f1)};
                matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
                matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
                matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
                matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
                matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
                matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
                matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
                matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
                matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
                matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
                matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
                matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

                spm_jobman('run',matlabbatch);
                clear matlabbatch;

                system(['bash mp_diffpow24.sh ',fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['rp_',subject,'_3T_tfMRI_MOTOR_LR.txt']),' ',fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',['rp24_',subject,'_3T_tfMRI_MOTOR_LR.txt'])]);

            end

            % The motion regressors for the first-level analysis are stored in a
            % file rp_{subject}.txt. We build the 24-regressor file
            % rp24_{subject}.txt which also contains the derivatives, squares and
            % squares of derivatives of the initial motion regressors, thanks to a
            % bash script, mp_diffpow24.sh

            matlabbatch{1}.spm.spatial.coreg.estimate.ref = {spm_file(f,'prefix','mean')};
            matlabbatch{1}.spm.spatial.coreg.estimate.source = {a1};
            matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
            matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
            matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
            matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
            matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];


            matlabbatch{2}.spm.spatial.preproc.channel.write = [0 1];
            matlabbatch{2}.spm.spatial.preproc.channel.vols  = {a1};
            matlabbatch{2}.spm.spatial.preproc.warp.mrf = 1;
            matlabbatch{2}.spm.spatial.preproc.warp.cleanup = 1;
            matlabbatch{2}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
            matlabbatch{2}.spm.spatial.preproc.warp.affreg = 'mni';
            matlabbatch{2}.spm.spatial.preproc.warp.fwhm = 0;
            matlabbatch{2}.spm.spatial.preproc.warp.samp = 3;
            matlabbatch{2}.spm.spatial.preproc.warp.write    = [1 1];

            spm_jobman('run',matlabbatch);
            clear matlabbatch;    
            
            
            f_r = spm_select('FPList', fullfile(data_path,'data',subject,'unprocessed','3T','tfMRI_MOTOR_LR'),['^','r',subject,'_3T_tfMRI_MOTOR_LR.nii$']);            
            f1_r = spm_select('expand',f_r);
            f_mean = spm_select('FPList', fullfile(data_path,'data',subject,'unprocessed','3T','tfMRI_MOTOR_LR'),['^','mean',subject,'_3T_tfMRI_MOTOR_LR.nii$']);

            defo = cellstr(spm_file(a,'prefix','y_'));

            matlabbatch{1}.spm.spatial.normalise.write.subj.def      = defo;
            matlabbatch{1}.spm.spatial.normalise.write.subj.resample = cellstr([spm_file(f1_r);spm_file(f_mean)]);
            matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                                      78 76 85];
            matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
            matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
            matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';


            matlabbatch{2}.spm.spatial.normalise.write.subj.def      = defo;
            matlabbatch{2}.spm.spatial.normalise.write.subj.resample = cellstr(spm_file(a1,'prefix','m'));
            matlabbatch{2}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                                      78 76 85];
            matlabbatch{2}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
            matlabbatch{2}.spm.spatial.normalise.write.woptions.interp = 4;
            matlabbatch{2}.spm.spatial.normalise.write.woptions.prefix = 'w';


            spm_jobman('run',matlabbatch);
            clear matlabbatch;    
        end
        
        f_wr = spm_select('FPList', fullfile(data_path,'data',subject,'unprocessed','3T','tfMRI_MOTOR_LR'),['^','wr',subject,'_3T_tfMRI_MOTOR_LR.nii$'])            
        f1_wr = spm_select('expand',f_wr)

        if smooth_value == '8'
            matlabbatch{1}.spm.spatial.smooth.data = cellstr([spm_file(f1_wr)]);
            matlabbatch{1}.spm.spatial.smooth.fwhm = [8 8 8];
            matlabbatch{1}.spm.spatial.smooth.dtype = 0;
            matlabbatch{1}.spm.spatial.smooth.im = 0;
            matlabbatch{1}.spm.spatial.smooth.prefix = 's8';
            spm_jobman('run',matlabbatch);
            clear matlabbatch;    
        elseif smooth_value == '5'            
            matlabbatch{1}.spm.spatial.smooth.data = cellstr([spm_file(f1_wr)]);
            matlabbatch{1}.spm.spatial.smooth.fwhm = [5 5 5];
            matlabbatch{1}.spm.spatial.smooth.dtype = 0;
            matlabbatch{1}.spm.spatial.smooth.im = 0;
            matlabbatch{1}.spm.spatial.smooth.prefix = 's5';
            spm_jobman('run',matlabbatch);
            clear matlabbatch;    
        end    
    end
    
    
    
    % Once the files have been created, we delete the .zip archives as well
    % as the useless files and directories which are contained in the
    % unzipped directories

    clean_octave(subject);
end
