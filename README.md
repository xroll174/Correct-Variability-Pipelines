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

## data

The data used in the study are the functional and structural fMRI data from the HCP subjects who have completed the Motor Task (*{subject}\_3T_Structural_unproc.zip* and *{subject}\_3T_tfMRI_MOTOR_unproc.zip*). They have to be downloaded from the HCP website into the data folder in order to allow the functions and scripts to work.

## functions

Matlab functions have been created to carry out the various steps of the analysis. The functions created for the study can be used to perform either a complete analysis for given groups of subjects and pipeline parameters, or simply parts of the analysis. Versions of the Matlab functions that are compatible with Octave have also been created (with *\_octave* added at the end of the filename) ; those are the versions that are called in the bash scripts when running the analysis (see *reproducing full analysis* below).

Octave/Matlab functions and auxiliary files are stored in the **src folder**. The main functions are **preprocessing**, **first_level_analysis** and **second_level_analysis**, each performing one step, and **full_analysis**, which performs the whole process for one couple of groups. Each of these functions is described in detail in comment at the beginning of their files.

## results

[results]

## Data analysis

### Raw data

Archives of the unprocessed structural data and functional data for the Motor Paradigm of the 1080 subjects of the Human Connectome Project who have completed the study were downloaded from https://db.humanconnectome.org/ into the `data` folder.

### Dependencies and setup
Octave 5.1 and SPM12 for Octave were used.

The folder path for SPM12 was specified in the file `./bash_scripts/spmpath.txt`. Additionally, the paths to other functions (not included in `src`) were specified in `bash_scripts/srcpath.txt`.

### Preprocessing and first-level analysis

First, we performed the preprocessing and first-level analysis for the 1080 subjects with the following pipelines:
 - `5_6_1`: smoothing FWHM=5, 6 motion regressors, HRF with temporal derivatives
 - `ADD_OTHER_PIPELINES_HERE`
using `./bash_scripts/preprocessing_{parameter values}_list_IGRIDA.sh` (preprocessing) and `./bash_scripts/fla_{parameter values}_list_IGRIDA.sh` (first-level analyses) where `{parameter values}` is replaced by the code given above for each pipeline.

We have two scripts for preprocessing and 12 scripts for first-level analysis. 

### Second-level analysis and false positive rates

Then, the between-group analyses (1000 repetitions for each couple of pipelines) were performed using `./bash_scripts/second_level_analysis_param_IGRIDA.sh {params pipeline 1} {params pipeline 2}` where `{params pipeline 1}` was the parameters for the first pipeline and `{params pipeline 2}` was the parameters of the second pipeline.

For example, we used `./bash_scripts/second_level_analysis_param_IGRIDA.sh 5 8 6 24 0 1` to perform the between-group analyses comparing pipeline FWHM=5, 6 motion regressors and HRF without temporal derivatives with pipeline FWHM=8, 24 motion regressors and HRF with temporal derivative.

For each between-group analysis {i}, the unthresholded and thresholded maps were stored in their own subfolder `data/SLA{i}\_50` (for the example above: `data/SLA{i}\_50/smooth\_5\_8/reg\_6\_24/der\_0\_1`).

Once all the between-group analysis for a given pair of pipeline were done, the false positive rates were computed for each between-group analysis using `./bash_scripts/false_positive_rate_full_param_IGRIDA.sh {params pipeline 1} {params pipeline 2}` where `{params pipeline 1}` and `{params pipeline 2}` were defined as for the between-group analyses. The false positive rates were stored in the FPR.mat file within the between-group analysis folder (for the above example `data/SLA{i}\_50/smooth\_5\_8/reg\_6\_24/der\_0\_1/FPR.mat`).
