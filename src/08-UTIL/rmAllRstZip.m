function [] = rmAllRstZip(scnTmp)
%RMALLRSTZIP  Remove All Restart Zipped Files
%   
%
%   See also mkRL, mkCase, dataClass.
h =@(x) task(x);
allCases(scnTmp,h);
end
function [] = task(caseName)
    rmRstZip(caseName);
end
