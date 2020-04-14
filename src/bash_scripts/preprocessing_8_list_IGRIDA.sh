sub=($@)

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<${#sub[@]};i++))
do
    oarsub -l /nodes=1/core=4,walltime=1:0:0 ". /etc/profile.d/modules.sh; module load octave-5.1.0-gcc-9.1.0; $DIR/preprocessing_8_list.sh ${sub[i]}"
done
