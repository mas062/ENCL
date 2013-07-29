function [] = mkAllRV(scnTmp)
%RVALL Result Visualizations for All Cases
%   rvAll(scnTmp) takes the scenario template scnTmp and performs 
%   visualization on grid for all realization runs on that scenario.
%
%   See also mkRv.

%%
%
task = @(cs) mkRV(cs);
allCases(scnTmp,task);
end