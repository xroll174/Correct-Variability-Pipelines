smooth1=$1
smooth2=$2
reg1=$3
reg2=$4
der1=$5
der2=$6
dec=$7
p1=$8
p2=$9
size=$10
corr=$11

DIR=$( dirname ${BASH_SOURCE})


srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)

octave --eval "addpath $spmpath; addpath $srcpath; second_level_analysis_octave_mult_hand_size_corr_prop($smooth1,$smooth2,$reg1,$reg2,$der1,$der2,$((1+10*$dec)),$((10+10*$dec)),$p1/$p2,$size,$corr)"
