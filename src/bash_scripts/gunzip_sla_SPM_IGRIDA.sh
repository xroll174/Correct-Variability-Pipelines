DIR=$( dirname ${BASH_SOURCE})

for ((i=1; i<1001;i++))
do
    oarsub -l /nodes=1/core=4,walltime=10:0 "gunzip -r data/SLA${i}_50_hand/*/*/*;"
done
