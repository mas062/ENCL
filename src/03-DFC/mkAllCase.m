function [] = mkAllCase(scnTmp)
%MKALLCASE  Scenario Construction Function
%   mkAllCase(scnTmp) takes the scenario template scnTmp and makes relevant
%   Eclipse data files for all classes and subclasses of realizations.
%
%   See also mkRL, mkCase, dataClass.
h =@(x) task(x);
allCases(scnTmp,h);
end
function [] = task(caseName)
rlz = case2rlz(caseName);
scn = case2scn(caseName);
if isRlz(rlz),
    mkCase(scn,rlz);
end
end
