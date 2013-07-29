function [ yes_no ] = runIt(caseName)
%RUNIT Run It
%   runIt(caseName) returns Boolean value which is true if the case is not
%   run already, and no if it is run. This is using information in the
%   runs.lst file in CASE directory.
%
%   See also runEclAll.

%%
yes_no = true;
%
runLst = [enclDir 'LOG/' case2scn(caseName) '_runs.lst'];
if exist(runLst,'file'),
    fid = fopen(runLst,'rt');
    while ~feof(fid) && yes_no,
        lin = fgetl(fid);
        if lin ~= -1,
            cs = textscan(lin,'%s');
            yes_no = ~strcmp(caseName,char(cs{1}));
        end
    end
    fclose(fid);
end
end

