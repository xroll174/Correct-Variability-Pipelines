# pipelines



## How to cite ?

[CITATION]

# Contents Overview
This repository contains code that was used to analyze and create the figures of the manuscript cited above. The code is organised as follows:

```
.

├── data: .zip archives downloaded from the Human Connectome Project
├── results: storage of the analysis results
└── src: source code for the analysis
```

## Reproducing full analysis

### Raw data

The data used in the study are the raw functional and structural fMRI data from the 1080 HCP subjects who have completed the Motor Task (*{subject}_3T_Structural_unproc.zip* and *{subject}_3T_tfMRI_MOTOR_unproc.zip*). Archives were downloaded from https://db.humanconnectome.org/ into the `data` folder.

### Dependencies and setup

Octave 5.1 and SPM12 for Octave were used.

The folder path for SPM12 was specified in the file `.src/bash_scripts/spmpath.txt`. Additionally, the paths to the folder containing the functions was stored in `./src/bash_scripts/srcpath.txt`.

### Preprocessing with SPM

Run  `./src/bash_scripts/preprocessing_<PARAM_PREPROC>_list_IGRIDA.sh "<SUB1> <SUB2> <SUB3>"` in a terminal where `<SUB1>`, `<SUB2>`, `<SUB3>`, etc. are the HCP subject identifiers as found in `src/src/list_subjects_ordered_full.txt` (this can be used to run preprocessing for part of the subjects to account for reduced storage space) and `<PARAM_PREPROC>` is taken from the table below.

| PARAM_PREPROC        | Pipeline parameters           |
| ------------- |:-------------:|
| 5      | smoothing 5mm |
| 8      | smoothing 8mm |

### First-Level Analyses with SPM

1. To perform first-level analysis and obtain the left foot contrast, run `./src/bash_scripts/fla_<PARAM_FLA>_list_IGRIDA.sh "<SUB1> <SUB2> <SUB3>"` in a terminal where `<SUB1>`, `<SUB2>`, `<SUB3>`, etc. are the HCP subject identifiers as found in `src/src/list_subjects_ordered_full.txt` (this can be used to run preprocessing for part of the subjects to account for reduced storage space) and `<PARAM_FLA>` is taken from the table below.

2. Similarly to 1., run `./src/bash_scripts/fla_<PARAM_FLA>_list_hand_IGRIDA.sh "<SUB1> <SUB2> <SUB3>"` in a terminal to obtain the right hand contrast.


| PARAM_FLA        | Pipeline parameters           |
| ------------- |:-------------:|
| 5_0_0      | smoothing 5mm, no motion regressors, canonical HRF |
| 5_0_1      | smoothing 5mm, no motion regressors, canonical HRF with temporal derivatives |
| 5_6_0      | smoothing 5mm, 6 motion regressors, canonical HRF  |
| 5_6_1      | smoothing 5mm, 6 motion regressors, canonical HRF with temporal derivatives  |
| 5_24_0      | smoothing 5mm, 24 motion regressors, canonical HRF  |
| 5_24_1      | smoothing 5mm, 24 motion regressors, canonical HRF with temporal derivatives  |
| 8_0_0      | smoothing 8mm, no motion regressors, canonical HRF |
| 8_0_1      | smoothing 8mm, no motion regressors, canonical HRF with temporal derivatives |
| 8_6_0      | smoothing 8mm, 6 motion regressors, canonical HRF  |
| 8_6_1      | smoothing 8mm, 6 motion regressors, canonical HRF with temporal derivatives  |
| 8_24_0      | smoothing 8mm, 24 motion regressors, canonical HRF  |
| 8_24_1      | smoothing 8mm, 24 motion regressors, canonical HRF with temporal derivatives  |


### Preprocessing and first-level analysis with FSL

Similarly to the previous SPM scripts, we use scripts `./src/bash_scripts/preprocessing_{parameter values}_list_fsl_IGRIDA.sh` and `./src/bash_scripts/fla_{parameter values}_list_hand_fsl_IGRIDA.sh` to perform preprocessing and first-level analysis on subject data with FSL.

### Second-level analysis and false positive rates

Then, the between-group analyses (1000 repetitions for each couple of pipelines) were performed using `./src/bash_scripts/second_level_analysis_param_hand_size_corr_IGRIDA.sh {params pipeline 1 and 2} {size} {corr}` where `{params pipeline 1 and 2}` were the parameters of both pipelines, `{size}` the number of subjects in both groups for second-level analysis and `{corr}` a value that indicates what type of thresholding we use (0 : uncorrected, p>0.001, 1 : FWE correction, p>0.05). We used size=50 and corr=1 for our present study.

For example, we used `./src/bash_scripts/second_level_analysis_param_hand_size_corr_IGRIDA.sh 5 8 6 24 0 1 50 1` to perform the 1000 between-group analyses comparing pipeline FWHM=5, 6 motion regressors and HRF without temporal derivatives with pipeline FWHM=8, 24 motion regressors and HRF with temporal derivative.

For each between-group analysis {i}, the unthresholded and thresholded maps were stored in their own subfolder `data/SLA{i}_50_hand_FWE` (for the example above: `data/SLA{i}_50_hand_FWE/smooth_5_8/reg_6_24/der_0_1`).

Once all the between-group analysis for a given pair of pipeline were done, the false positive rates were computed for each between-group analysis using `./bash_scripts/false_positive_rate_full_param_hand_size_corr_IGRIDA.sh {params pipeline 1 and 2} {size} {corr}` where `{params pipeline 1 and 2}`, `{size}` and `{corr}` were defined as for the between-group analyses. The false positive rates were stored in the FPR.mat file within the between-group analysis folder (for the above example `data/SLA{i}_50_FWE_hand/smooth_5_8/reg_6_24/der_0_1/FPR.mat`). The resulting estimation of the false positive rate for each couple of pipeline was calculated and stored in the following file : `results/smooth_{s1}_reg_{r1}_der_{d1}/smooth_{s2}_reg_{r2}_der_{d2}/mean_hand_50_FWE.mat` (with s1, d1, r1, s2, d2, r2 the parameter values for both pipelines).
