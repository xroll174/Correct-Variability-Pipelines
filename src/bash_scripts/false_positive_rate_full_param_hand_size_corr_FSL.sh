smooth1=$1
smooth2=$2
reg1=$3
reg2=$4
der1=$5
der2=$6
size=$7
corr=$8

DIR=$( dirname ${BASH_SOURCE})


srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)

octave --eval "addpath $spmpath; addpath $srcpath; false_positive_rate_octave_full_hand_size_corr_fsl($smooth1,$smooth2,$reg1,$reg2,$der1,$der2,$size,$corr)"
