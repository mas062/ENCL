function [] = itsApre(caseName)
%ITSAPRE Apre Run Is Done
%   itsApre(caseName) adds caseName into the list of cases in
%   the apre.lst file in CASE directory.
%
%   See also apreIt, itsRun, runIt, runEclAll.

%%
fid = fopen([enclDir 'LOG/' case2scn(caseName) '_apre.lst'],'a+');
fprintf(fid,'%s \n',caseName);
fclose(fid);
%
end

