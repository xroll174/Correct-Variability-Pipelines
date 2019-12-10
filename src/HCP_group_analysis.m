% We have 12 possible pipelines for the preprocessing and first-level
% analysis of subjects data, which makes 144 possible couple of pipelines.
% We create a list of 1000 groups with 60 different subjects ids chosen
% randomly among the HCP subjects which have completed the Motor Task. For
% each group of subject, for each couple of pipeline, we perform a group
% analysis between the 30 first subjects, preprocessed and analyzed with
% the first pipeline and the 30last subjects analyzed with the second
% pipeline.


list_groups = importdata('list_couples_subjects_HCP.mat');


% list_groups contains a list of 1000 groups of 60 subjects id from the
% 1080 HCP subjects which have completed the Motor Task

param_smooth = ['5','8'];
param_reg = ['0','6','24'];
param_der = ['0','1'];

for i = 1:length(LC)
    
    % The design matrix and estimated parameters and contrasts for a given
    % group are stored in a folder called 'Group_i', in subfolders
    % depending on the parameter values
    
    
    folder_name = ['Group_',num2str(i)];

    for j1 = 1:length(param_smooth)
        for j2 = 1:length(param_smooth)
            for k1 = 1:length(param_reg)
                for k2 = 1:length(param_reg)
                    for l1 = 1:length(param_der)
                        for l2 = 1:length(param_der)
                            
                            % j1, k1, l1 give the parameter values for the
                            % first pipeline and j2, k2, l2 for the second
                            % one
                            
                        end
                    end
                end
            end
        end
        
    end
    
end

