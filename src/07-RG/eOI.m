function [smryEOI,rstEOI] = eOI(smry,rst)
%EOI End Of Injection
%   [smryEOI,rstEOI] = eOI(smry,rst) takes the summary and restart 
%   converted data and extracts the end of injection report step number. 
%   
%   See also mkRV, mkRP.

%%
smryTimeInd = find(smry.WOIR(1,:));
smryEOI = smryTimeInd(end)
timeOIS = smry.TIME(smryEOI);
rstEOI = find([rst.times] == timeOIS);
dif = abs(rstEOI-rst.timeindex);
rstEOI = find(dif == min(dif));
%
end

