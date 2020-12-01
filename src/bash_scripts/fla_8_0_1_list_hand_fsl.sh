#!/bin/bash

. /etc/profile.d/modules.sh
module load neurinfo/fsl/5.0.10
. ${FSLDIR}/etc/fslconf/fsl.sh

sub=$@

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})
# DIR gives us the directory of the script, which also contains the .txt files containing the pathes for the octave functions directory and spm directory, which will be stored in variables srcpath and spmpath.


fslpath=$(cat $DIR/fslpath.txt)
fulldir=$(cat $DIR/fulldir.txt)

srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)

for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}
    
    
    FILE=data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat/reg_standard/stats/cope1.nii
    if ! [ -f "$FILE" ]; then

	rm -r data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat

	rm src/design_fsf/design_fla_${sub[i]}_8_0_1.fsf
	
	python3 -c "import sys; sys.path.insert(1,'src/src'); from script_generation_fla import script_gen_fla; script_gen_fla(${sub[i]},8,0,1,'$fulldir','$fslpath');"

	feat src/design_fsf/design_fla_${sub[i]}_8_0_1.fsf

	mkdir -r data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat/reg

	scp -r data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR_FSL_5.feat/reg data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat/reg

	featregapply data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat

	gunzip data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat/reg_standard/stats/cope1.nii.gz

	octave --eval "addpath $spmpath; addpath $srcpath; masking_fsl(${sub[i]},8,0,1)"

	rm data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat/filtered_func_data.nii.gz

	rm -r data/${sub[i]}/fsl_analysis/smooth_8/reg_0/der_1.feat/reg
    fi
done
