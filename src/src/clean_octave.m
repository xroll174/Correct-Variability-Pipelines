function [] = clean_octave(sujet)
    sujet = num2str(sujet);
    Lfile = [fullfile('data',[sujet,'_3T_Structural_unproc.zip']);
    fullfile('data',[sujet,'_3T_Structural_unproc.zip.md5']);
    fullfile('data',[sujet,'_3T_tfMRI_MOTOR_unproc.zip']);
    fullfile('data',[sujet,'_3T_tfMRI_MOTOR_unproc.zip.md5']);
    fullfile('data',sujet,'unprocessed','3T','T1w_MPR1',[sujet,'_3T_BIAS_32CH.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','T1w_MPR1',[sujet,'_3T_BIAS_BC.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','T1w_MPR1',[sujet,'_3T_FieldMap_Magnitude.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','T1w_MPR1',[sujet,'_3T_FieldMap_Phase.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','T1w_MPR1',[sujet,'_3T_MPR1.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','tfMRI_MOTOR_LR',[sujet,'_3T_BIAS_32CH.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','tfMRI_MOTOR_LR',[sujet,'_3T_BIAS_BC.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','tfMRI_MOTOR_LR',[sujet,'_3T_SpinEchoFieldMap_LR.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','tfMRI_MOTOR_LR',[sujet,'_3T_SpinEchoFieldMap_RL.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','tfMRI_MOTOR_LR',[sujet,'_3T_tfMRI_MOTOR_LR.nii.gz']);
    fullfile('data',sujet,'unprocessed','3T','tfMRI_MOTOR_LR',[sujet,'_3T_tfMRI_MOTOR_LR_SBRef.nii.gz'])]

    Ldir = [fullfile('data',sujet,'unprocessed','3T','T2w_SPC1');
    fullfile('data',sujet,'unprocessed','3T','tfMRI_MOTOR_RL')];
    
for i = 1:(size(Lfile)(1))
	      j = deblank(Lfile(i,:));
              delete(j);
    end
    
    for i = 1:(size(Ldir(i)))
	      j = deblank(Ldir(i,:));
              rmdir(j);
    end    
end
