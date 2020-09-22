# pipelines



## How to cite ?

[CITATION]

# Contents Overview
This repository contains code that was used to analyze and create the figures of the manuscript cited above. The code is organised as follows:

```
.
├── bash_scripts: scripts used for preprocessing and first-level analysis, and auxiliary files for these scripts
├── check_scripts: scripts used for the verification of the existence of output files from the analysis
├── data: .zip archives downloaded from the Human Connectome Project
├── results: storage of the analysis results
└── src: Matlab/Octave functions for the various steps of the analysis, either called in bash scripts from the bash_scripts folder, or used directly via Matlab (second-level analysis) during the analysis
```

## functions

For SPM, Matlab functions have been created to carry out the various steps of the analysis. The functions created for the study can be used to perform either a complete analysis for given groups of subjects and pipeline parameters, or simply parts of the analysis. Versions of the Matlab functions that are compatible with Octave have also been created (with *\_octave* added at the end of the filename) ; those are the versions that are called in the bash scripts when running the analysis (see *reproducing full analysis* below).

Octave/Matlab functions and auxiliary files are stored in the **src/src folder**. The main functions are **preprocessing**, **first_level_analysis** and **second_level_analysis**, each performing one step, and **full_analysis**, which performs the whole process for one couple of groups. Each of these functions is described in detail in comment at the beginning of their files.

The src/src folder also contains **.fsf template files and .py python files** used to create .fsf files for preprocessing and first-level analysis with FSL for each subject.

## results

[results]

## Reproducing full analysis

### Raw data

The data used in the study are the functional and structural fMRI data from the HCP subjects who have completed the Motor Task (*{subject}_3T_Structural_unproc.zip* and *{subject}_3T_tfMRI_MOTOR_unproc.zip*). They have to be downloaded from the HCP website into the data folder in order to allow the functions and scripts to work.

Archives of the unprocessed structural data and functional data for the Motor Paradigm of the 1080 subjects of the Human Connectome Project who have completed the study were downloaded from https://db.humanconnectome.org/ into the `data` folder.

### Dependencies and setup
Octave 5.1 and SPM12 for Octave were used.

The folder path for SPM12 was specified in the file `.src/bash_scripts/spmpath.txt`. Additionally, the paths to the folder containing the functions was stored in `./src/bash_scripts/srcpath.txt`.

### Preprocessing and first-level analysis with SPM

First, we performed the preprocessing and first-level analysis for the 1080 subjects with the following pipelines: `5_0_0`, `5_0_1`, `5_6_0`, `5_6_1`, `5_24_0`, `5_24_1`, `8_0_0`, `8_0_1`, `8_6_0`, `8_6_1`, `8_24_0`, `8_24_1`, where the first value is the smoothing kernel FWHM in mm, the second value is the number of motion regressors and the last value indicates the presence or absence of the HRF's temporal derivatives in the GLM model.

the scripts `./src/bash_scripts/preprocessing_{parameter values}_list_IGRIDA.sh` and `./src/bash_scripts/fla_{parameter values}_list_hand_IGRIDA.sh` were used for preprocessing and first-level analysis respectively, where `{parameter values}` is replaced by `5` or `8` in preprocessing, and by the code given above for each pipeline in first-level analysis. Therefore we have two scripts for preprocessing and 12 scripts for first-level analysis.

### Preprocessing and first-level analysis with FSL

Similarly to the previous SPM scripts, we use scripts `./src/bash_scripts/preprocessing_{parameter values}_list_fsl_IGRIDA.sh` and `./src/bash_scripts/fla_{parameter values}_list_hand_fsl_IGRIDA.sh` to perform preprocessing and first-level analysis on subject data with FSL.

### Second-level analysis and false positive rates

Then, the between-group analyses (1000 repetitions for each couple of pipelines) were performed using `./src/bash_scripts/second_level_analysis_param_hand_size_corr_IGRIDA.sh {params pipeline 1 and 2} {size} {corr}` where `{params pipeline 1 and 2}` were the parameters of both pipelines, `{size}` the number of subjects in both groups for second-level analysis and `{corr}` a value that indicates what type of thresholding we use (0 : uncorrected, p>0.001, 1 : FWE correction, p>0.05). We used size=50 and corr=1 for our present study.

For example, we used `./src/bash_scripts/second_level_analysis_param_hand_size_corr_IGRIDA.sh 5 8 6 24 0 1 50 1` to perform the 1000 between-group analyses comparing pipeline FWHM=5, 6 motion regressors and HRF without temporal derivatives with pipeline FWHM=8, 24 motion regressors and HRF with temporal derivative.

For each between-group analysis {i}, the unthresholded and thresholded maps were stored in their own subfolder `data/SLA{i}_50_hand_FWE` (for the example above: `data/SLA{i}_50_hand_FWE/smooth_5_8/reg_6_24/der_0_1`).

Once all the between-group analysis for a given pair of pipeline were done, the false positive rates were computed for each between-group analysis using `./bash_scripts/false_positive_rate_full_param_hand_size_corr_IGRIDA.sh {params pipeline 1 and 2} {size} {corr}` where `{params pipeline 1 and 2}`, `{size}` and `{corr}` were defined as for the between-group analyses. The false positive rates were stored in the FPR.mat file within the between-group analysis folder (for the above example `data/SLA{i}_50_FWE_hand/smooth_5_8/reg_6_24/der_0_1/FPR.mat`). The resulting estimation of the false positive rate for each couple of pipeline was calculated and stored in the following file : `results/smooth_{s1}_reg_{r1}_der_{d1}/smooth_{s2}_reg_{r2}_der_{d2}/mean_hand_50_FWE.mat` (with s1, d1, r1, s2, d2, r2 the parameter values for both pipelines).
