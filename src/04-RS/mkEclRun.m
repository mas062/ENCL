function [ varargout ] = mkEclRun( caseName )
%MKECLRUN Make Eclipse Run
%   mkEclRun(caseName) takes the case root name caseName and produces the 
%   csh command file for running the case by Eclipse. This can be called by
%   eclRun or eclAll functions.
%
%   See also eclRun, eclAll, mkScn.

%%
% Extract information from the given case name
csNum = caseName(7:8);
rNum = caseName(12:13);
scnNum = caseName(18:19);
% Path to the case
csD = [enclDir '02-HetVarStudy/C' num2str(csNum) '/R_C'  num2str(csNum) ...
    '_SC' num2str(rNum) '/ENCL_C' num2str(csNum) '_SC' num2str(rNum) ...
    '_SCN' num2str(scnNum) '/SCN/'];
% csh file 
cmdFN = [csD caseName '.csh'];
fid = fopen(cmdFN,'wt');
cmd = ['/home/meisam/ecl/macros/@eclipse -override -data ' csD ...
    ' -file ' caseName];
fprintf(fid,'%s \n','#!/bin/csh');
fprintf(fid,'%s \n',cmd);
fclose(fid);
end

