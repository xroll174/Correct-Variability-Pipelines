for smooth1 in 5 8
do
    for smooth2 in 5 8
    do
	for reg1 in 0 6 24
	do
	    for reg2 in 0 6 24
	    do
		for der1 in 0 1
		do
		    for der2 in 0 1
		    do
		        oarsub -l /nodes=1/core=4,walltime=1:0:0 "$DIR/false_positive_rate_full_param_hand_size_corr.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 50 1"
		    done
		done
	    done
	done
    done
done
