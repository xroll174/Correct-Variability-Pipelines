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
		        echo "$smooth1 $smooth2 $reg1 $reg2 $der1 $der2"
			a=0
			for ((i=1; i<1001;i++))
			do
			    FILE=data/SLA${i}_50_hand/smooth_${smooth1}_${smooth2}/reg_${reg1}_${reg2}/der_${der1}_${der2}/spmT_0001_thresholded_FWE.nii.gz
			    if ! [ -f "$FILE" ]; then
				a=$(($a+1))
			    fi
			done
			echo "$a"
			if [ $a -gt 0 ]; then
			    for ((i=0; i<100;i++))
			    do
				echo $i
				b=0
				for ((j=1; j<11;j++))
				do
				    FILE=data/SLA$((10*$i+$j))_50_hand/smooth_${smooth1}_${smooth2}/reg_${reg1}_${reg2}/der_${der1}_${der2}/spmT_0001_thresholded_FWE.nii.gz
				    if ! [ -f "$FILE" ]; then
					b=$(($b+1))
				    fi
				done
				if [ $b -gt 0 ]; then
			            oarsub -l /nodes=1/core=4,walltime=40:0 "$DIR/second_level_analysis_param_hand_size_corr.sh $smooth1 $smooth2 $reg1 $reg2 $der1 $der2 $i 50 1"
				    sleep 2s
				fi
			    done
		        fi
		    done
		done
	    done
	done
    done
done
