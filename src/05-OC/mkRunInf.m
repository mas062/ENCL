function [] = mkRunInf(caseName)
Abandoned for future developement. Not required yet.
%MKRUNINFO Make Run Information File
%   mkRunInfo(caseName) extracts the necessary run information for case
%   caseName. These data are saved in a mat file in VCT directory specific
%   to caseName. 
%
%   See also.

%%
% Load data from SCN directory
[smry,rst] = readEclipseResults([pthSCN(caseName) caseName]);
smryTimeInd = find(smry.WOIR(1,:));
smryEOI = smryTimeInd(end)
timeOIS = smry.TIME(smryEOI);
rstEOI = find(rst.times==timeOIS)

end

