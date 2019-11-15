# pipelines



## How to cite ?

[CITATION]

# Contents Overview

The goal of our study is to preprocess and analyzed data from the Human Connectome Project at the first-level using different pipelines, which differ from each other on specific parameters, and then carry out group analyses on groups of subjects data which have been processed either with the same pipeline or with different pipelines, to see if there are significant differences in results that are induced by the preprocessing and first-level analysis pipelines.

The repository contains functions and scripts for the execution of preprocessing, first-level and second level analysis pipelines on subjects data taken from the Human Connectome Project. These functions take as input subjects id or list of subjects id from the HCP data, as well as parameters chosen for the pipeline (value of the FHWM for smoothing, number of motion regressors and presence or absence of temporal derivatives of the main regressors in the first-level design matrix).

## data

The data used in the study are the functional and structural fMRI data from the HCP subjects who have completed the Motor Task ( {subject}\_3T_Structural_unproc.zip and {subject}\_3T_tfMRI_MOTOR_unproc.zip). They have to be downloaded from the HCP website into the data folder in order to allow the functions and scripts to work.

## functions

[full analysis]
[FLA_list]
[first_level_analysis]
[preprocessing]
[clean, deldir, delfile]
[second level analysis]
[false_positive_rate]

## results

[results]

## reproducing full analysis

[reproducing full analysis]
