DIR=$( dirname ${BASH_SOURCE})

for ((i=1; i<1001;i++))
do
    oarsub -l /nodes=1/core=4,walltime=10:0 "gunzip -r data/SLA${i}_50_hand/*/*/*/spmT_0001_thresholded_FWE.nii.gz; gunzip -r data/SLA${i}_50_hand/*/*/*/spmT_0002_thresholded_FWE.nii.gz; gunzip -r data/SLA${i}_50_hand/*/*/*/mask.nii.gz"
done
