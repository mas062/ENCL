function [] = mkFltrCase(scnTmp,dim,sbc)
%MKFLTRCASE  Scenario Construction Function 
%   mkFltrCase(scnTmp,dim) takes the scenario template scnTmp and makes relevant
%   Eclipse data files for filtered classes and subclasses of realizations. 
%
%   See also mkRL, mkCase, dataClass, fltrCases.
h =@(x) task(x);
fltrCases(scnTmp,h,dim,sbc);
end
function [] = task(caseName)
rlz = case2rlz(caseName);
scn = case2scn(caseName);
if isRlz(rlz),
    mkCase(scn,rlz);
end
end
