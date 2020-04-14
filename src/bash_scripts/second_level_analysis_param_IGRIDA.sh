smooth1=$1
smooth2=$2
reg1=$3
reg2=$4
der1=$5
der2=$6

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<100;i++))
do
    oarsub -l /nodes=1/core=4,walltime=1:20:0 -p "dedicated='neurinfo'" ". /etc/profile.d/modules.sh; module load octave-5.1.0-gcc-9.1.0; $DIR/second_level_analysis_param.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 $i"
done
