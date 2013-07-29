function [] = rmAllVCT(scnTmp)
%RMALLVCT  Remove All Vector Files
%   
%
%   See also mkRL, mkCase, dataClass.
h =@(x) task(x);
allCases(scnTmp,h);
end
function [] = task(caseName)
    rmVCT(caseName);
end
