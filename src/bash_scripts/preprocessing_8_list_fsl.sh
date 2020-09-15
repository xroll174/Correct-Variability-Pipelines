sub=($@)

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})
. /etc/profile.d/modules.sh
# DIR gives us the directory of the script, which also contains the .txt files containing the pathes for the octave functions directory and spm directory, which will be stored in variables srcpath and spmpath.

for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}

    GZSTRUCT=data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1.nii.gz
    GZFUNC=data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/${sub[i]}_3T_tfMRI_MOTOR_LR.nii.gz

    if ! [ -f "$GZSTRUCT" ]; then
	unzip data/${sub[i]}_3T_Structural_unproc.zip -d data
    fi
    
    if ! [ -f "$GZFUNC" ]; then
	unzip data/${sub[i]}_3T_tfMRI_MOTOR_unproc.zip -d data
    fi
    
    module load neurinfo/fsl/5.0.10
    BRAINFILE=data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1_brain.nii.gz
    if ! [ -f "$BRAINFILE" ]; then
	bet2 data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1 data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1_brain
    fi
    
    FILE=data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR_FSL_8.feat/filtered_func_data.nii.gz
    if ! [ -f "$FILE" ]; then
	python3 -c "from script_generation import script_gen; script_gen(${sub[i]},8,1);"
	feat src/design_fsf/design_preproc_${sub[i]}_8.fsf
    fi
done
