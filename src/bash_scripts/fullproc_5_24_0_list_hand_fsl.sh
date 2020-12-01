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
    
    GZSTRUCT=data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1.nii.gz
    GZFUNC=data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/${sub[i]}_3T_tfMRI_MOTOR_LR.nii.gz

    if ! [ -f "$GZSTRUCT" ]; then
	unzip data/${sub[i]}_3T_Structural_unproc.zip -d data
    fi
    
    if ! [ -f "$GZFUNC" ]; then
	unzip data/${sub[i]}_3T_tfMRI_MOTOR_unproc.zip -d data
    fi

    scp -r data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/LINKED_DATA/EPRIME/EVs data/${sub[i]}
    
    BRAINFILE=data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1_brain.nii.gz
    if ! [ -f "$BRAINFILE" ]; then
	bet2 data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1 data/${sub[i]}/unprocessed/3T/T1w_MPR1/${sub[i]}_3T_T1w_MPR1_brain
    fi
    
    FILE=data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat/reg_standard/stats/cope1.nii
    if ! [ -f "$FILE" ]; then

	rm -r data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat

	rm src/design_fsf/design_fullproc_${sub[i]}_5_24_0.fsf
	
	python3 -c "import sys; sys.path.insert(1,'src/src'); from script_generation_fullproc import script_gen_fullproc; script_gen_fullproc(${sub[i]},5,24,0,'$fulldir','$fslpath');"

	feat src/design_fsf/design_fullproc_${sub[i]}_5_24_0.fsf
	
	mkdir -r data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat/reg

	scp -r data/${sub[i]}/fsl_analysis/smooth_5/reg_0/der_0.feat/reg/* data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat/reg
	
	updatefeatreg data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat -gifs

	featregapply data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat

	gunzip data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat/reg_standard/stats/cope1.nii.gz
	
	octave --eval "addpath $spmpath; addpath $srcpath; masking_fsl(${sub[i]},5,24,0)"

	rm data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat/filtered_func_data.nii.gz

	rm -r data/${sub[i]}/fsl_analysis/smooth_5/reg_24/der_0.feat/reg
    fi
done
