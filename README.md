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

## reproducing full analysis

### Downloading the raw data

Archives of the unprocessed structural data and functional data for the Motor Paradigm of the 1080 subjects of the Human Connectome Project who have completed the study must be downloaded on https://db.humanconnectome.org/ into the `data` folder.

### Dependencies and setup
Octave 5.1 and SPM12 for Octave must be installed on the computer to perform the analysis correctly.

The folder path for SPM12 must be specified in the file `./bash_scripts/spmpath.txt`. Also, if there is a need to put the functions in a directory other than src, the name and absolute or relative path of this directory can be specified in `bash_scripts/srcpath.txt`.


### Preprocessing and first-level analysis

Preprocessing and first-level analysis for the 1080 subjects were done using scripts for each parameter valuation, named `./bash_scripts/preprocessing_{parameter values}_list_IGRIDA.sh` and `./bash_scripts/fla_{parameter values}_list_IGRIDA.sh`, which take as input a list of id of subjects that we want to process.

For example `./bash_scripts/fla_5_6_1_list_IGRIDA.sh "100206 113821 204218"` performs first-level analysis (and preprocessing if not done already) with FWHM=5 for smoothing, 6 motion regressors and presence of temporal derivatives for subjects with id 100206, 113821 and 204218.

We have two scripts for preprocessing and 12 scripts for first-level analysis. The whole preprocessing and first-level analysis was performed by calling each of these scripts on the whole 1080 subjects.

*NB: For practical reasons, a computing grid was used and the scripts mentioned above specifically use it to submit jobs. For persons who do not have access to the computing grid, the following scripts can perform the same task:* `./bash_scripts/{analysis step}_{parameters}_list.sh` *(same name without the _IGRIDA suffix)*

### Second-level analysis and false positive rates

Bash scripts were also used for second-level analysis and extraction of false positive rates. A single script named `./bash_scripts/second_level_analysis_param_IGRIDA.sh`, performs the 1000 inter-group analysis for two pipelines, with their parameters as input. For example, `./bash_scripts/second_level_analysis_param_IGRIDA.sh 5 8 6 24 0 1` performs the 1000 inter-group analysis with the first group processed with the pipeline with FWHM smoothing kernel equal to 5mm, 6 motion regressors and no temporal derivatives, and the second group processed with the pipeline with FWHM smoothing kernel equal to 8mm, 24 motion regressors and presence of temporal derivatives.

For each inter-group analysis {i}, the unthresholded and thresholded maps for second level analysis with specific parameters are stored in a specific subfolder of folder data/SLA{i}\_50 (for example, with the parameters given above, data/SLA{i}\_50/smooth\_5\_8/reg\_6\_24/der\_0\_1).

Once all the inter-group analysis for a given pair of pipeline are done, the false positive rates are extracted for each inter-group analysis using the script `./bash_scripts/false_positive_rate_full_param_IGRIDA.sh` which take as input the parameter values of both pipelines, like the second-level analysis script, and stores the false positive rate value for each inter-group analysis in a FPR.mat file within the inter-group analysis folder (for example, data/SLA{i}\_50/smooth\_5\_8/reg\_6\_24/der\_0\_1/FPR.mat for the parameters given above).
