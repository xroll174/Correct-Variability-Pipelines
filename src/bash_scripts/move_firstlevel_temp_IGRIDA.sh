sub=($@)

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<${#sub[@]};i++))
do
    oarsub -l /nodes=1/core=4,walltime=0:30:0 "scp -r data/${sub[i]} data/old_fsl; rm -r data/${sub[i]}"
done

