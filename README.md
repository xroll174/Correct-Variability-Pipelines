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

1. Run `./src/bash_scripts/second_level_analysis_full_hand_spm_IGRIDA.sh` to perform the 1000 group analyses for every pair of pipelines.

2. Run `./src/bash_scripts/false_positive_rate_full_hand_spm_IGRIDA.sh` to obtain the empirical false positive rate for every pair of pipelines.

The resulting estimation of the false positive rate for each pair of pipeline is stored in the following file : `results/smooth_<SMOOTH1>_reg_<REG1>_der_<DER1>/smooth_<SMOOTH2>_reg_<REG2>_der_<DER2>/mean_hand_50_FWE.mat`, with `<SMOOTH1>`, `<REG1>`, `<DER1>` the parameter values for the first pipeline and `<SMOOTH2>`, `<REG2>`, ` <DER2> ` for the second pipeline, taken from the tables below.

| SMOOTH1, SMOOTH2        | Pipeline parameters           |
| ------------- |:-------------:|
| 5      | smoothing 5mm |
| 8      | smoothing 8mm |

| REG1, REG2        | Pipeline parameters           |
| ------------- |:-------------:|
| 0      | no motion regressors |
| 6      | 6 motion regressors |
| 24      | 24 motion regressors |

| DER1, DER2        | Pipeline parameters           |
| ------------- |:-------------:|
| 0      | canonical HRF |
| 1      | canonical HRF with temporal derivatives |
