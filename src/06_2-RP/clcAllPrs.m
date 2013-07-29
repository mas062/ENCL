function [] = clcAllPrs(scnTmp)
%CLCALLPRS Calculate All Pressure Plot Vectors
%   clcAllPrs(scnTmp) takes the scenario template scnTmp and produces 
%   the pressure plot vectors for all realization runs on that scenario.
%
%   See also prsClcPlt, clcPlt, clcAllPlt.

%%
task = @(cs) prsClcPlt(cs);
allCases(scnTmp,task);
%
end
