function [] = rmAllPLT(scnTmp)
%RMALLPLT  Remove All Plot Vector Files
%   
%
%   See also rmAllVCT, mkRL, mkCase, dataClass.
h =@(x) task(x);
allCases(scnTmp,h);
end
function [] = task(caseName)
    rmPLT(caseName);
end
