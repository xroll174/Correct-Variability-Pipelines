smooth1=$1
smooth2=$2
reg1=$3
reg2=$4
der1=$5
der2=$6
soft1=$7
soft2=$8
dec=$9
size=$10
corr=$11

DIR=$( dirname ${BASH_SOURCE})


srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)

octave --eval "addpath $spmpath; addpath $srcpath; second_level_analysis_octave_mult_hand_size_corr($smooth1,$smooth2,$reg1,$reg2,$der1,$der2,$((1+10*$dec)),$((10+10*$dec)),$soft1,$soft2,$size,$corr)"
