function [L2] = extract_ev(subject)
    
    % We create a table which contains the EV onset times, which are
    % specified in FSL format in the HCP data
    
    subject = char(string(subject))
    
    param_list = ["lf","lh","rf","rh","t"];
    L2 = []
    for j = 1:length(param_list)
        a0 = importdata(fullfile('data',subject,'unprocessed','3T','tfMRI_MOTOR_LR','LINKED_DATA','EPRIME','EVs',[char(param_list(j)),'.txt']));
        L2 = [L2;a0(1,1),a0(2,1)];
    end
end