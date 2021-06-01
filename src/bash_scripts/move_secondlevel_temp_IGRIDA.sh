DIR=$( dirname ${BASH_SOURCE})

for ((i=1; i<1001;i++))
do
    oarsub -l /nodes=1/core=4,walltime=0:30:0 "scp -r data/SLA${i}_50_hand_FSL data/old_fsl_sla; rm -r data/SLA${i}_50_hand_FSL"
done

