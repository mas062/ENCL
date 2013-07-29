function [ yes_no ] = apreIt(caseName)
%APREIT Perform Post Run Taks
%   apreIt(caseName) returns Boolean value which is true if the apreRun
%   function has not already been run for the case caseName.
%   This is using information in the apre.lst file in CASE directory.
%
%   See also runIt, runEclAll.

%%
yes_no = true;
%
apreLst = [enclDir 'LOG/' case2scn(caseName) '_apre.lst'];
if exist(apreLst,'file'),
    fid = fopen(apreLst,'rt');
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

