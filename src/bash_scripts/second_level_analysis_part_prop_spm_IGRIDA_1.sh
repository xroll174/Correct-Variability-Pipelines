DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<100;i++))
do
    echo "5 24 0 8 24 0"
    echo $i
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop.sh 5 8 24 24 0 0 $i 4 5 50 1"
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop_cov.sh 5 8 24 24 0 0 $i 4 5 50 1"
done

for ((i=0; i<100;i++))
do
    echo "5 24 0 5 0 0"
    echo $i
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop.sh 5 5 24 0 0 0 $i 4 5 50 1"
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop_cov.sh 5 5 24 0 0 0 $i 4 5 50 1"
done

for ((i=0; i<100;i++))
do
    echo "5 24 0 5 24 1"
    echo $i
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop.sh 5 5 24 24 0 1 $i 4 5 50 1"
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop_cov.sh 5 5 24 24 0 1 $i 4 5 50 1"
done

for ((i=0; i<100;i++))
do
    echo "5 24 0 8 0 0"
    echo $i
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop.sh 5 8 24 0 0 0 $i 4 5 50 1"
    oarsub -l /nodes=1/core=4,walltime=0:40:0 "$DIR/second_level_analysis_param_hand_size_corr_prop_cov.sh 5 8 24 0 0 0 $i 4 5 50 1"
done
