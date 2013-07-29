function [] = mkAllVP(scnTmp)
%MKALLVP Make All Variational Plots
%   mkAllVP(scnTmp) plots varaiational results along all variational
%   parameters.
%
%   See also mkVP, mkCP.

%%
task = @(cs) mkRV(cs);
allCases(scnTmp,task);
%
end

