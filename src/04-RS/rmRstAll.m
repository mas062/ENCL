function [] = rmRstAll(scnTmp)
%RUNALLECL Run All Eclipse Models
%   runAllEcl(scnTmp) Submits runs to Eclipse for all the generated cases
%   relevant to scnTmp scenario template. 
%
%   See also mkCase, mkEcl, runEcl, mkAllCase, mkAllEcl.

%%
h = @(x) rmRst(x);
allCases(scnTmp,h);
end
