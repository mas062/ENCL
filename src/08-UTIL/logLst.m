function [] = logLst(caseName,lstName)
%LOGLST Log List
%   logLst(caseName,lstName) adds caseName into the list of already
%   performed a specific task. The relevant name comes in lstName.
%
%   See also itsRun, itsApre.

%%
fid = fopen([enclDir 'LOG/' case2scn(caseName) '_' lstName '.lst'],'a+');
fprintf(fid,'%s \n',caseName);
fclose(fid);
%
end