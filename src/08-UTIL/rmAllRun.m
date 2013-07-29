function [] = rmAllRun(scnTmp)
%RMALLRUN  Remove All Run
%   
%
%   See also rmRun.
h =@(x) task(x);
allCases(scnTmp,h);
end
function [] = task(caseName)
    rmRun(caseName);
end
