sub=($@)

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})

# DIR gives us the directory of the script, which also contains the .txt files containing the pathes for the octave functions directory and spm directory, which will be stored in variables srcpath and spmpath.

srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)
for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}
    octave --eval "addpath $spmpath; addpath $srcpath; preprocessing_octave(${sub[i]},5)"
    octave --eval "addpath $spmpath; addpath $srcpath; preprocessing_octave(${sub[i]},8)"
    ./src/src/mp_diffpow24.sh data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/rp_${sub[i]}_3T_tfMRI_MOTOR_LR.txt data/${sub[i]}/unprocessed/3T/tfMRI_MOTOR_LR/rp24_${sub[i]}_3T_tfMRI_MOTOR_LR.txt
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},5,0,0)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},5,0,1)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},5,6,0)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},5,6,1)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},5,24,0)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},5,24,1)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},8,0,0)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},8,0,1)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},8,6,0)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},8,6,1)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},8,24,0)"
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},8,24,1)"
done
