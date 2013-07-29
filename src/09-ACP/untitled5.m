ck = false;
while ~ck,
    M = SGDst_rslt;
    chk1 = (Roots(3)>0.097)*(Roots(3)<0.103);
    chk2 = (Roots(2)>0.497)*(Roots(2)<0.5030);
    chk3 = (Roots(1)>0.897)*(Roots(1)<0.903);
    ck = chk1 && chk2 && chk3; 
end
Mdis = M;
save './bestdist.mat' Mdis