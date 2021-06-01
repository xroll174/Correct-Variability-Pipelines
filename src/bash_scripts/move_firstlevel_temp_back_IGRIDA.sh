sub=($@)

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<${#sub[@]};i++))
do
    oarsub -l /nodes=1/core=4,walltime=0:30:0 "scp -r data/old_fsl/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1.nii.gz data/${sub[i]}/unprocessed/3T/T1w_MPR1 ; scp -r data/old_fsl/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/${sub[i]}_3T_tfMRI_MOTOR_LR.nii.gz data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR"
done

