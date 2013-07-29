function [] = mkEcl( caseName )
%MKECL Make Eclipse
%   mkEcl(caseName) takes the case root name caseName and produces the 
%   csh command file for running the case by Eclipse. This can be called by
%   eclRun or eclAll functions.
%
%   See also eclRun, eclAll, mkScn.

%%
mkCMD(caseName);
% Path to CMD directory
cmdD = pthCMD(caseName);
% csh file 
cmdFN = [cmdD caseName '.csh'];
fid = fopen(cmdFN,'wt');
cmd = [pthEcl '/@eclipse -override -data ' pthSCN(caseName) ...
    ' -file ' caseName];
fprintf(fid,'%s \n','#!/bin/csh');
fprintf(fid,'%s \n',cmd);
fclose(fid);
end

