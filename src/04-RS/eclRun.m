function [ varargout ] = eclRun( caseName )
%ECLRUN Eclipse Run
%   eclRun(caseName) takes the case root name and executes the relevant csh
%   command file produced by mkEclRun function.
%
%   See also mkEclRun, eclAll, mkCase.

%%
% Make sure that the csh file exists by rebuilding it
mkEclRun(caseName);
% Extract information from the given case name
csNum = caseName(7:8);
rNum = caseName(12:13);
scnNum = caseName(18:19);
% Path to the case
csD = [enclDir '02-HetVarStudy/C' num2str(csNum) '/R_C'  num2str(csNum) ...
    '_SC' num2str(rNum) '/ENCL_C' num2str(csNum) '_SC' num2str(rNum) ...
    '_SCN' num2str(scnNum) '/SCN/'];
cmdFN = [csD caseName '.csh'];
% Execute the csh file.
cmd = ['csh ' cmdFN];
system(cmd);
end

