sub=($@)

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<${#sub[@]};i++))
do
    oarsub -l /nodes=1/core=4,walltime=4:0:0 "$DIR/full_individual_analysis_list_hand_fsl.sh ${sub[i]}"
done
