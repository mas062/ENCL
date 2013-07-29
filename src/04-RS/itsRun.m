function [] = itsRun(caseName)
%ITSRUN It Is Run
%   itsRun(caseName) adds caseName into the list of already run cases in
%   the runs.lst file in CASE directory.
%
%   See also runIt, runEclAll.

%%
logLst(caseName,'runs');
%
end

