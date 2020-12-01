#!/bin/bash

. /etc/profile.d/modules.sh
module load neurinfo/fsl/5.0.10
. ${FSLDIR}/etc/fslconf/fsl.sh

sub=$@

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})
# DIR gives us the directory of this script, which also contains the .txt files containing the absolute pathes of the pipelines folder and the fsl folder.

fslpath=$(cat $DIR/fslpath.txt)
fulldir=$(cat $DIR/fulldir.txt)

for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}

    EVFILE=data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/LINKED_DATA/EPRIME/EVs/rh.txt
    
    if ! [ -f "$EVFILE" ]; then
	unzip data/${sub[i]}_3T_tfMRI_MOTOR_unproc.zip -d data
    fi

    scp -r data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/LINKED_DATA/EPRIME/EVs data/${sub[i]}

done
