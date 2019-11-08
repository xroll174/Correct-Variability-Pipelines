function [] = clean(sujet)
    sujet = char(string(sujet));
    Lfile = [string([sujet,'_3T_Structural_unproc.zip']);
    string([sujet,'_3T_Structural_unproc.zip.md5']);
    string([sujet,'_3T_tfMRI_MOTOR_unproc.zip']);
    string([sujet,'_3T_tfMRI_MOTOR_unproc.zip.md5']);
    string([sujet,'/unprocessed/3T/T1w_MPR1/',sujet,'_3T_BIAS_32CH.nii.gz']);
    string([sujet,'/unprocessed/3T/T1w_MPR1/',sujet,'_3T_BIAS_BC.nii.gz']);
    string([sujet,'/unprocessed/3T/T1w_MPR1/',sujet,'_3T_FieldMap_Magnitude.nii.gz']);
    string([sujet,'/unprocessed/3T/T1w_MPR1/',sujet,'_3T_FieldMap_Phase.nii.gz']);
    string([sujet,'/unprocessed/3T/T1w_MPR1/',sujet,'_3T_MPR1.nii.gz']);
    string([sujet,'/unprocessed/3T/tfMRI_MOTOR_LR/',sujet,'_3T_BIAS_32CH.nii.gz']);
    string([sujet,'/unprocessed/3T/tfMRI_MOTOR_LR/',sujet,'_3T_BIAS_BC.nii.gz']);
    string([sujet,'/unprocessed/3T/tfMRI_MOTOR_LR/',sujet,'_3T_SpinEchoFieldMap_LR.nii.gz']);
    string([sujet,'/unprocessed/3T/tfMRI_MOTOR_LR/',sujet,'_3T_SpinEchoFieldMap_RL.nii.gz']);
    string([sujet,'/unprocessed/3T/tfMRI_MOTOR_LR/',sujet,'_3T_tfMRI_MOTOR_LR.nii.gz']);
    string([sujet,'/unprocessed/3T/tfMRI_MOTOR_LR/',sujet,'_3T_tfMRI_MOTOR_LR_SBRef.nii.gz'])];

    Ldir = [string([sujet,'/unprocessed/3T/T2w_SPC1']);
        string([sujet,'/unprocessed/3T/tfMRI_MOTOR_RL'])];
    
    for i = 1:length(Lfile)
        j = char(Lfile(i));
        delfile(j);
    end
    
    for i = 1:length(Ldir)
        j = char(Ldir(i));
        deldir(j);
    end    
end