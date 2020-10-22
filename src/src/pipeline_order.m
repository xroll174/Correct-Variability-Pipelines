function [a] = pipeline_order(smooth,reg,der)
    if smooth==5
        s=0;
    else
        s=1;
    end
    if reg==0
        r=0;
    elseif reg==6
        r=1;
    else
        r=2;
    end
    d=der;
    a=6*s+2*r+d+1;
end