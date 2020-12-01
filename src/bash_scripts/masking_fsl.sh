sub=($@)

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})

# DIR gives us the directory of the script, which also contains the .txt files containing the pathes for the octave functions directory and spm directory, which will be stored in variables srcpath and spmpath.

srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)
for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}
    for s in 5 8
    do
        for r in 0 6 24
	do
	    for d in 0 1
	    do
		gunzip data/${sub[i]}/fsl_analysis/smooth_${s}/reg_${r}/der_${d}.feat/reg_standard/mask.nii.gz
		octave --eval "addpath $spmpath; addpath $srcpath; masking_fsl(${sub[i]},${s},${r},${d})"
	    done
	done
    done
done
