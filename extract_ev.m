function [L2] = extract_ev(subject)
    param_list = ["lf","lh","rf","rh","t"];
    L2 = []
    for j = 1:length(param_list)
        a0 = importdata([char(string(subject)),'/unprocessed/3T/tfMRI_MOTOR_LR/LINKED_DATA/EPRIME/EVs/',char(param_list(j)),'.txt']);
        L2 = [L2;a0(1,1),a0(2,1)];
    end
end