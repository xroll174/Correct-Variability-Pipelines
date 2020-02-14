%    The main function in the repository is full_analysis, which takes a couple of lists of subject id, parameters chosen for smoothing, motion regressors and temporal derivative for both group pipelines and a folder name as input, performs the preprocessing and first-level analysis on the subject data with the parameters chosen as input if they have not already been done, then carry out the second-level analysis, which is a group analysis on the activation for the left-foot movement (corresponding for every subject to the beta_0001 parameter estimated). This also corresponds to a contrast [1 0 ... 0] for all subjects and all analyses.

%    Once the second-level analysis has been performed, the function returns the proportion of voxels with a statistic value corresponding to p > 0.05.

%    The possible parameter values for the pipeline are 5 and 8 for the smoothing FWHM value, 0, 6 or 24 for the number of motion regressors (no motion regressors, 6 motion regressors estimated during realignment or these regressors + their derivatives, squares and squares of derivatives), and 0 or 1 for the absence or presence of temporal derivatives of the main regressors. They can be entered either as integer or string or char. These are also the possible parameter values for every other function that takes pipeline parameters as input in the study.

%    Example : with L1, L2 being lists of subject id from HCP, full_analysis(L1,L2,5,8,6,24,0,1,'folder_name') will perform the preprocessing and first-level analysis of L1 subjects with smoothing FWHM value equal to 5, 6 regressors and no temporal derivatives in the design matrix for the first-level analysis if it has not been done already, do the same with subjects in L2 with smoothing FWHM value equal to 8, 24 regressors and presence of temporal derivatives, perform second-level analysis and store the design matrix and statistical map for second-level analysis in folder /results/folder_name/smooth_5_8/reg_6_24/der_0_1/.

%    The function uses auxiliary functions for each task. FLA_list performs the first-level analysis (and preprocessing) of a list of subjects data with given parameters, second_level_analysis performs the second-level analysis on a couple of group of first-level analyses data from preprocessed and analyzed subjects for given parameters, and false_positive_rate returns the proportion of voxels with a statistic value corresponding to p > 0.05 on a second-level statistic map in a specific folder for specific parameter values. These auxiliary functions contains other functions themselves, and these can be used to perform specific steps of the analysis individually.



function [rate] = full_analysis(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,folder)

    % for the same input as the second_level_analysis function (couple of
    % groups of subjects and pipeline parameter values, and folder name),
    % we perform preprocessing and first-level analysis for the given
    % parameters on every subject if it has not already been done, and then
    % the second-level analysis between both groups. The function returns
    % the proportion of false positives in the resulting statistical map
        
    FLA_list(list_1,smooth1,reg1,der1)
    FLA_list(list_2,smooth2,reg2,der2)
    
    second_level_analysis(list_1,list_2,smooth1,smooth2,reg1,reg2,der1,der2,folder)
    
    rate = false_positive_rate(smooth1,smooth2,reg1,reg2,der1,der2,folder)
end
