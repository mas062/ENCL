function [] = mkAllEcl(scnTmp)
%MKALLECL Make All Eclipse Command Files
%   mkEclAll(scnTmp) takes the scenario template name scnTmp and produces
%   the csh command file for all the generated cases. This can be called by
%   runEcl or mkAllEcl functions.
% 
%   See also runEcl, mkCase, mkEcl, runAllEcl.

%%
h =@(x) task(x);
allCases(scnTmp,h);
%
end
function [] = task(caseName)
display(['Writing luanch commands for case ' caseName]);
mkEcl(caseName);
%
end
