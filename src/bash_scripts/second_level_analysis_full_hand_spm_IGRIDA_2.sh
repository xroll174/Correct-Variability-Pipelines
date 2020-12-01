DIR=$( dirname ${BASH_SOURCE})


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
		        if [ $smooth1 -gt $smooth2 ]; then
			    for ((i=0; i<100;i++))	
			    do
			        oarsub -l /nodes=1/core=4,walltime=40:0 "$DIR/second_level_analysis_param_hand_size_corr.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 $i 50 1"
			    done
			    sleep 8m
			elif [ $smooth1 -eq $smooth2 ]; then
                            if [ $reg1 -gt $reg2 ]; then
                                for ((i=0; i<100;i++))
                                do
			            oarsub -l /nodes=1/core=4,walltime=40:0 "$DIR/second_level_analysis_param_hand_size_corr.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 $i 50 1"
			        done
				sleep 8m
                            elif [ $reg1 -eq $reg2 ]; then
                                if [ $der1 -gt $der2 ]; then
				    for ((i=0; i<100;i++))
			            do
			                oarsub -l /nodes=1/core=4,walltime=40:0 "$DIR/second_level_analysis_param_hand_size_corr.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 $i 50 1"
       			            done
				    sleep 8m
                                fi
                            fi
			fi
		    done
		done
	    done
	done
    done
done
