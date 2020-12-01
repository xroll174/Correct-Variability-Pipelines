#!/bin/bash

. /etc/profile.d/modules.sh
module load neurinfo/fsl/5.0.10
. ${FSLDIR}/etc/fslconf/fsl.sh

sub=($@)

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})
# DIR gives us the directory of this script, which also contains the .txt files containing the absolute pathes of the pipelines folder and the fsl folder.

fslpath=$(cat $DIR/fslpath.txt)
fulldir=$(cat $DIR/fulldir.txt)

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
    
    BRAINFILE=data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1_brain.nii.gz
    if ! [ -f "$BRAINFILE" ]; then
	bet2 data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1 data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1_brain
    fi
    
    FILE=data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR_FSL_8.feat/filtered_func_data.nii.gz
    echo "$FILE"
    if ! [ -f "$FILE" ]; then

	rm -r data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR_FSL_8.feat

	rm src/design_fsf/design_preproc_${sub[i]}_8.fsf
	
	python3 -c "import sys; sys.path.insert(1,'src/src'); from script_generation import script_gen; script_gen(${sub[i]},8,1,'$fulldir','$fslpath');"
	feat src/design_fsf/design_preproc_${sub[i]}_8.fsf
    fi
done
