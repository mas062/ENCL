function [] = mkFltrEcl(scnTmp,dim,sbc)
%MKALLECL Make Filtered Eclipse Command Files
%   mkEclAll(scnTmp) takes the scenario template name scnTmp and produces
%   the csh command file for filtered generated cases. 
% 
%   See also runEcl, mkCase, mkEcl, runAllEcl, fltrCases.

%%
h =@(x) task(x);
fltrCases(scnTmp,h,dim,sbc);
%
end
function [] = task(caseName)
display(['Writing luanch commands for case ' caseName]);
mkEcl(caseName);
%
end
