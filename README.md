# pipelines



## How to cite ?

[CITATION]

# Contents Overview
This repository contains code to reproduce the analyses and figures of the manuscript cited above. The code is organised as follows:

```
.
├── bash_scripts: <Add description here>
├── check_scripts: <Add description here>
├── data: <Add description here>
├── results: <Add description here>
└── src: <Add description here>
```

## data

The data used in the study are the functional and structural fMRI data from the HCP subjects who have completed the Motor Task (*{subject}\_3T_Structural_unproc.zip* and *{subject}\_3T_tfMRI_MOTOR_unproc.zip*). They have to be downloaded from the HCP website into the data folder in order to allow the functions and scripts to work.

## functions

Matlab functions have been created to carry out the various steps of the analysis. The functions created for the study can be used to perform either a complete analysis for given groups of subjects and pipeline parameters, or simply parts of the analysis. Versions of the Matlab functions that are compatible with Octave have also been created (with *\_octave* added at the end of the filename) ; those are the versions that are called in the bash scripts when running the analysis (see *reproducing full analysis* below).

Octave/Matlab functions and auxiliary files are stored in the **src folder**.

### full_analysis

The main function in the repository is **full_analysis**, which takes  a couple of lists of subject id, parameters chosen for smoothing, motion regressors and temporal derivative for both group pipelines and a folder name as input, performs the preprocessing and first-level analysis on the subject data with the parameters chosen as input if they have not already been done, then carry out the second-level analysis, which is a group analysis on the activation for the left-foot movement (corresponding for every subject to the beta_0001 parameter estimated). This also corresponds to a contrast [1 0 ... 0] for all subjects and all analyses.

Once the second-level analysis has been performed, the function returns the proportion of voxels with a statistic value corresponding to p > 0.05.

The possible parameter values for the pipeline are 5 and 8 for the smoothing FWHM value, 0, 6 or 24 for the number of motion regressors (no motion regressors, 6 motion regressors estimated during realignment or these regressors + their derivatives, squares and squares of derivatives), and 0 or 1 for the absence or presence of temporal derivatives of the main regressors. They can be entered either as integer or string or char. **These are also the possible parameter values for every other function that takes pipeline parameters as input in the study.**

Example : with L1, L2 being lists of subject id from HCP, *full_analysis(L1,L2,5,8,6,24,0,1,'folder_name')* will perform the preprocessing and first-level analysis of L1 subjects with smoothing FWHM value equal to 5, 6 regressors and no temporal derivatives in the design matrix for the first-level analysis if it has not been done already, do the same with subjects in L2 with smoothing FWHM value equal to 8, 24 regressors and presence of temporal derivatives, perform second-level analysis and store the design matrix and statistical map for second-level analysis in folder /results/folder_name/smooth_5_8/reg_6_24/der_0_1/.

The function uses auxiliary functions for each task. **FLA_list** performs the first-level analysis (and preprocessing) of a list of subjects data with given parameters, **second_level_analysis** performs the second-level analysis on a couple of group of first-level analyses data from preprocessed and analyzed subjects for given parameters, and **false_positive_rate** returns the proportion of voxels with a statistic value corresponding to p > 0.05 on a second-level statistic map in a specific folder for specific parameter values. These auxiliary functions contains other functions themselves, and these can be used to perform specific steps of the analysis individually.

### second_level_analysis

**second_level_analysis** takes the same inputs as full_analysis and creates the statistical maps at the second level in the folder defined above for full_analysis. The subjects must already have been preprocessed and analyzed at the first level in order to carry out the second level analysis. A design matrix SPM.mat is created in the folder, and a contrast [-1 1] is applied to have the difference between both groups. (Example : *second_level_analysis(L1,L2,5,8,6,24,0,1,'folder_name')*)

### first_level_analysis and FLA_list

**first_level_analysis** takes as input a subject id, smoothing, regressor and derivative parameters, and carry out the first level analysis (creation of the design matrix SPM.mat and estimation of the beta_i) on the subject for the given parameters unless it has already been done. The preprocessing of the data is also carried out if it has not already been done. (Example : *first_level_analysis(100206,5,6,1)*)

As described in the task fMRI protocol details for the Human Connectome Project, the main regressors ar five movement types (left foot, left hand, right foot, right hand, tongue) with block events lasting for 12 seconds with amplitude 1. The event times, which are slightly different for each subject, are stored in FSL format in files *lf.txt*, *lh.txt*, *rf.txt*, *rh.txt* and *t.txt* in the folder *{subject}/unprocessed/3T/tfMRI_MOTOR_LR/LINKED_DATA/EPRIME/EVs*. We use an auxiliary function **extract_ev** to create a file *{subject}/ev.mat* which contains the event times for the subject.

The first level analysis data are stored in the folder *{subject}/analysis/smooth_i/reg_j/der_k* with i, j and k being the parameter values entered as input.

**FLA_list** does the same but with a list of subject instead of a single subject, using **first_level_analysis** as an auxiliary function.

### preprocessing

**preprocessing** takes a subject id and a smoothing FWHM value, and performs the preprocessing of the data with the smoothing value given as input if it has not already been done. (Example : *preprocessing(100206,5)*)

The function first unzip the data if the unzipped data does not exist yet. Realignment, normalization and smoothing are performed on the data. If the preprocessing has already been done on the subject with another smoothing value, realignment and normalization have already been carried out and the function only performs smoothing on the already normalized data.

Once the data have been preprocessed once, the zip archives are useless, as well as some of the data that are contained in the unzipped folder. We use a function **clean**, which deletes a list of directories and files using other functions **deldir** and **delfile** that delete a directory or file after checking if it exists.

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
