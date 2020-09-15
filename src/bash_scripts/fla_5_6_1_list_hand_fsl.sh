#!/bin/bash

. /etc/profile.d/modules.sh
module load neurinfo/fsl/5.0.10
. ${FSLDIR}/etc/fslconf/fsl.sh

sub=$@

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})
# DIR gives us the directory of the script, which also contains the .txt files containing the pathes for the octave functions directory and spm directory, which will be stored in variables srcpath and spmpath.

for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}
    
    
    FILE=data/${sub[i]}/analysis_fsl/smooth_5/reg_6/der_1.feat/stats/cope1.nii.gz
    if ! [ -f "$FILE" ]; then
	python3 -c "from script_generation_fla import script_gen_fla; script_gen_fla(${sub[i]},5,6,1);"
	feat src/design_fsf/design_fla_${sub[i]}_5_6_1.fsf
    fi
done
