function [V] = exists(sujet,smooth,reg,der)
    datapath = pwd;
    sujet = char(string(sujet));
    smooth = char(string(smooth));
    reg = char(string(reg));
    der = char(string(der));
    V = isfile([sujet,'/analysis/smooth_',smooth,'/reg_',reg,'/der_',der,'/beta_0001.nii']);
end