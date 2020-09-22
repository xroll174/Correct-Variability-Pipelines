def script_gen_fla(subject,smooth,reg,der,fulldir,fslpath):
    import os
    subject=str(subject)
    smooth=str(smooth)
    reg=str(reg)
    der=str(der)
    if reg=='O':
        regbis='1'
    elif reg=='6':
        regbis='2'
    else:
        regbis='24'
    replacements={'SUBJECT':subject, 'SMOOTH':smooth, 'REG':reg, 'REGBIS':regbis, 'DER':der, 'FSLPATH':fslpath, 'FULLDIR':fulldir}

    design_subject=open("src/design_fsf/design_fla_"+subject+"_"+smooth+"_"+reg+"_"+der+".fsf","w")
    design_template=open("src/design_fsf/design_fla_template.fsf")
    for line in design_template:
        for src,target in replacements.items():
            line = line.replace(src,target)
        design_subject.write(line)
    design_subject.close()
