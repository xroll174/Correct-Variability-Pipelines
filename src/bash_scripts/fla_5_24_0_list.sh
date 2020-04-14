sub=($@)

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})

# DIR gives us the directory of the script, which also contains the .txt files containing the pathes for the octave functions directory and spm directory, which will be stored in variables srcpath and spmpath.

srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)
for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}
    octave --eval "addpath $spmpath; addpath $srcpath; first_level_analysis_octave(${sub[i]},5,24,0)"
done
