function [] = pllEcl(scn,pll)
%PLLECL Parallel Eclipse
%   pllEcl(scn,pll) takes the scenario name scn and number of cpus to be
%   used in the parallel run and writes the command script for the runs.
%

%   See also eclRun, eclAll, mkScn.

%%

% Path to CMD directory
cmdD = ['/scratch/SAIGUP/DATA/CMD/PLL' num2str(pll)];

tmpF = [cmdD 'tmp.lst'];
%
if ~exist(cmdD,'dir'), cmd = ['mkdir ' cmdD];system(cmd);end;
%
% csh file 
h =@(x) task(x);
allCases(scn,h);
%
fid = fopen(tmpF,'rt');
setN = 0;
while ~feof(fid)
    setN = setN +1;
    cmdF = [cmdD scn '_' num2str(pll) '_' num2str(setN) '.cmd'];
    fjd = fopen(cmdF,'wt');
    fprintf(fjd,'%s \n','#!/bin/csh');
    for i = 1:pll,
        lin = fgetl(fid);
        fprintf(fjd,'%s \n',lin);     
    end
    fclose(fjd);
end
fclose(fid);
cmd = ['rm ' tmpF]; system(cmd);
end
function [] = task(caseName)
%%

    %
    cmdD = '/scratch/SAIGUP/DATA/CMD/';
    tmpF = [cmdD 'tmp.lst'];
    %
    fid = fopen(tmpF,'a');
    cmd = [pthEcl '/@eclipse -override -data ' pthSCN(caseName) ...
        ' -file ' caseName '&'];
    %fprintf(fid,'%s \n','#!/bin/csh');
    fprintf(fid,'%s \n',cmd);
    fclose(fid);
end

