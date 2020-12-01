def script_gen_fullproc(subject,smooth,reg,der,fulldir,fslpath):
    import os
    subject=str(subject)
    smooth=str(smooth)
    reg=str(reg)
    der=str(der)
    if reg=='0':
        regbis='0'
    elif reg=='6':
        regbis='1'
    else:
        regbis='2'
    if der=='0':
        contr4='1'
        contr7='0'
    else:
        contr4='0'
        contr7='1'
    if (smooth=='5' and reg=='0') and der=='0':
        regist='1'
    else:
        regist='0'
    
    replacements={'SUBJECT':subject, 'SMOOTH':smooth, 'REG1':reg, 'REG2':regbis, 'DER':der, 'REGIST':regist, 'CONTR4':contr4, 'CONTR7':contr7, 'FSLPATH':fslpath, 'FULLDIR':fulldir}

    design_subject=open("src/design_fsf/design_fullproc_"+subject+"_"+smooth+"_"+reg+"_"+der+".fsf","w")
    design_template=open("src/src/design_fullproc_template.fsf")
    for line in design_template:
        for src,target in replacements.items():
            line = line.replace(src,target)
        design_subject.write(line)
    design_subject.close()
