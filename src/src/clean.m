function [] = clean(subject)
    subject = char(string(subject));
    
    % We create lists of file and directory names, which correspond to the
    % zip files downloaded from HCP for a given subject as well as the
    % files and directories contained in the unzipped folder which are
    % useless for our study.
    
    Lfile = [string(fullfile('data',[subject,'_3T_Structural_unproc.zip']));
    string(fullfile('data',[subject,'_3T_Structural_unproc.zip.md5']));
    string(fullfile('data',[subject,'_3T_tfMRI_MOTOR_unproc.zip']));
    string(fullfile('data',[subject,'_3T_tfMRI_MOTOR_unproc.zip.md5']));
    string(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_BIAS_32CH.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_BIAS_BC.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_FieldMap_Magnitude.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_FieldMap_Phase.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','T1w_MPR1',[subject,'_3T_MPR1.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_BIAS_32CH.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_BIAS_BC.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_SpinEchoFieldMap_LR.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_SpinEchoFieldMap_RL.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_tfMRI_MOTOR_LR.nii.gz']));
    string(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR',[subject,'_3T_tfMRI_MOTOR_LR_SBRef.nii.gz']))];

    Ldir = [string(fullfile('data',subject,'unprocessed','3T','T2w_SPC1'));
        string(fullfile('data,'subject,'unprocessed','3T','tfMRI_MOTOR_RL']))];
    
    
    
    
    
    % We delete all the files that are in the lists above. The function is
    % supposed to be used after the initial structural and functional data
    % have been unzipped.
    
    for i = 1:length(Lfile)
        j = char(Lfile(i));
        delete(j);
    end
    
    for i = 1:length(Ldir)
        j = char(Ldir(i));
        rmdir(j);
    end    
end
