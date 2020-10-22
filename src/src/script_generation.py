def script_gen(subject,smooth,regist,fulldir,fslpath):
    import os
    subject=str(subject)
    smooth=str(smooth)
    regist=str(regist)
    replacements={'SUBJECT':subject, 'SMOOTH':smooth, 'FULLDIR':fulldir, 'FSLPATH':fslpath}
    if regist=='0':
        design_subject=open("src/design_fsf/design_preproc_"+subject+"_"+smooth+"_noreg.fsf","w")
        design_template=open("src/src/design_preproc_template_noreg.fsf")
        for line in design_template:
            for src,target in replacements.items():
                line = line.replace(src,target)
            design_subject.write(line)
        design_subject.close()
    else:
        design_subject=open("src/design_fsf/design_preproc_"+subject+"_"+smooth+".fsf","w")
        design_template=open("src/src/design_preproc_template.fsf")
        for line in design_template:
            for src,target in replacements.items():
                line = line.replace(src,target)
            design_subject.write(line)
        design_subject.close()
