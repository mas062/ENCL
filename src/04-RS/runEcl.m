function [ ] = runEcl( caseName )
%RUNECL Run Eclipse
%   runEcl(caseName) takes the case root name and executes the relevant csh
%   command file produced by mkEclRun function.
%
%   See also mkEcl, runEclAll, mkCase.

%%
%
msg = ['Running case ' caseName '...'];
display(msg);
logIt(msg);
%
% Make sure that the csh file exists by rebuilding it
mkEcl(caseName);
% Path to CMD folder
cmdFN = [pthCMD(caseName) caseName '.csh'];
% Execute the csh file.
cmd = ['csh ' cmdFN];
system(cmd);
end

