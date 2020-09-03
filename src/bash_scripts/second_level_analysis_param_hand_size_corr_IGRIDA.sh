smooth1=$1
smooth2=$2
reg1=$3
reg2=$4
der1=$5
der2=$6
size=$7
corr=$8

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<100;i++))
do
    oarsub -l /nodes=1/core=4,walltime=40:0 "$DIR/second_level_analysis_param_hand_size_corr.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 $i $size $corr"
done
