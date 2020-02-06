sub=($@)

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<${#sub[@]};i++))
do
    oarsub -l /nodes=1/core=4,walltime=1:0:0 "$DIR/preprocessing_8_list.sh ${sub[i]}"
done
