# pipelines



## How to cite ?

[CITATION]

# Contents Overview
This repository contains code to reproduce the analyses and figures of the manuscript cited above. The code is organised as follows:

```
.
├── bash_scripts: folder containing bash scripts used for preprocessing and first-level analysis, and auxiliary files for these scripts
├── check_scripts: folder containing bash scripts used for the verification of the existence of output files from the analysis
├── data: folder to store the .zip archives downloaded from the Human Connectome Project
├── results: folder where the results are stored after the analysis
└── src: folder containing Matlab/Octave functions for the various steps of the analysis, either called in bash scripts from the bash_scripts folder, or used directly via Matlab (second-level analysis) during the analysis
```

## data

The data used in the study are the functional and structural fMRI data from the HCP subjects who have completed the Motor Task (*{subject}\_3T_Structural_unproc.zip* and *{subject}\_3T_tfMRI_MOTOR_unproc.zip*). They have to be downloaded from the HCP website into the data folder in order to allow the functions and scripts to work.

## functions

Matlab functions have been created to carry out the various steps of the analysis. The functions created for the study can be used to perform either a complete analysis for given groups of subjects and pipeline parameters, or simply parts of the analysis. Versions of the Matlab functions that are compatible with Octave have also been created (with *\_octave* added at the end of the filename) ; those are the versions that are called in the bash scripts when running the analysis (see *reproducing full analysis* below).

Octave/Matlab functions and auxiliary files are stored in the **src folder**. The main functions are **preprocessing**, **first_level_analysis** and **second_level_analysis**, each performing one step, and **full_analysis**, which performs the whole process for one couple of groups. Each of these functions is described in detail in comment at the beginning of their files.

## results

[results]

## reproducing full analysis

### Downloading the raw data

Archives of the unprocessed structural data and functional data for the Motor Paradigm of the 1080 subjects of the Human Connectome Project who have completed the study must be downloaded on https://db.humanconnectome.org/ into the `data` folder.

### Dependencies and setup
Octave 5.1 and SPM12 for Octave must be installed on the computer to perform the analysis correctly.

The folder path for SPM12 must be specified in the file `./bash_scripts/spmpath.txt`. Also, if there is a need to put the functions in a directory other than src, the name and absolute or relative path of this directory can be specified in `bash_scripts/srcpath.txt`.


### Preprocessing and first-level analysis

The complete preprocessing/first-level analysis for all the 1080 subjects with the 12 pipelines can be reproduced by running the following script from a Terminal in the parent folder :

```
./bash_scripts/preproc_fla_complete.sh
```


*NB: due to a question of available space for the data, scripts for partial analysis (specific steps of the analysis or specific subjects) were used. These scripts are named* `./bash_scripts/{analysis step}_{parameters}_list.sh` *and take as input the list of subjects id to be processed, for example :*
`./bash_scripts/fla_5_6_1.sh "100206 113821 204218"` *performs first-level analysis (and preprocessing if not done already) with FWHM=5 for smoothing, 6 motion regressors and presence of temporal derivatives) for subjects with id 100206, 113821 and 204218.*

### Second-level analysis and false positive rates

Second-level analysis was performed using Matlab R2017b. To perform second-level analysis with given parameters for both group pipelines (here 5, 6 and 1 for both groups), run the following code inside Matlab:

```
addpath src
G1 = importdata('list_couples_subjects_HCP.mat')
for i=1:1000
	second_level_analysis(G1(i,1:30),G1(i,31:60),5,5,6,6,1,1,['SLA',num2str(i),'bis'])
end
```

Which will create the unthresholded and thresholded maps for the second-level analysis in specific subfolders of folders data/SLA{i}bis (for each group {i}).

To obtain the false positive rates within each thresholded map for given parameters (as above), run the following code in Matlab :

```
addpath src
for i=1:1000
	false_positive_rate(5,5,6,6,1,1,['SLA',num2str(i),'bis'])
end
```

The false positive rate will be stored in a file FPR.mat within the subfolder of the second-level analysis for each group.
