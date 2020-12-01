function [] = masking_fsl(subject,smooth_value,reg,der)
    data_path=pwd;
    
    spm('Defaults','fMRI');
    spm_jobman('initcfg');
    
    subject=num2str(subject);
    smooth_value=num2str(smooth_value);
    reg=num2str(reg);
    der=num2str(der);
    
    V1=spm_vol(fullfile(data_path,'data',subject,'fsl_analysis',['smooth_',smooth_value],['reg_',reg],['der_',der,'.feat'],'reg_standard','stats','cope1.nii'))
    V_con=spm_read_vols(V1);
V_mask=spm_read_vols(spm_vol(fullfile(data_path,'data',subject,'fsl_analysis',['smooth_',smooth_value],['reg_',reg],['der_',der,'.feat'],'reg_standard','mask.nii.gz')));
    a=size(V_mask)
    for i=1:a(1)
        for j=1:a(2)
            for k=1:a(3)
                if V_mask(i,j,k)==0
                    V_con(i,j,k)=NaN;
                end
            end
        end
    end
    spm_write_vol(V1,V_con);
end
