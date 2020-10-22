sub=($@)

# sub contains the list of subject ids given as input for preprocessing.

DIR=$( dirname ${BASH_SOURCE})

# DIR gives us the directory of the script, which also contains the .txt files containing the pathes for the octave functions directory and spm directory, which will be stored in variables srcpath and spmpath.

srcpath=$(cat $DIR/srcpath.txt)
spmpath=$(cat $DIR/spmpath.txt)
for ((i=0; i<${#sub[@]};i++))
do
    echo ${sub[i]}
    $DIR/preprocessing_5_list_fsl.sh ${sub[i]}

    $DIR/preprocessing_8_list_fsl.sh ${sub[i]}

    $DIR/fla_5_0_0_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_5_0_1_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_5_6_0_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_5_6_1_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_5_24_0_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_5_24_1_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_8_0_0_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_8_0_1_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_8_6_0_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_8_6_1_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_8_24_0_list_hand_fsl.sh ${sub[i]}
    $DIR/fla_8_24_1_list_hand_fsl.sh ${sub[i]}
done
