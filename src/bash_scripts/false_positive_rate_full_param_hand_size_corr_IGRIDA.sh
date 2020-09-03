smooth1=$1
smooth2=$2
reg1=$3
reg2=$4
der1=$5
der2=$6
size=$7
corr=$8

DIR=$( dirname ${BASH_SOURCE})

oarsub -l /nodes=1/core=4,walltime=1:0:0 "$DIR/false_positive_rate_full_param_hand_size_corr.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 $size $corr"
