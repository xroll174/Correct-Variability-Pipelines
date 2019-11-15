function [V] = exists(subject,smooth,reg,der)
    datapath = pwd;
    subject = char(string(subject));
    smooth = char(string(smooth));
    reg = char(string(reg));
    der = char(string(der));
    V = isfile([subject,'/analysis/smooth_',smooth,'/reg_',reg,'/der_',der,'/beta_0001.nii']);
end