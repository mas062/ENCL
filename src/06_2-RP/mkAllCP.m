function [] = mkAllCP(scnTmp)
%MKALLCP Make All Case Plots
%   mkAllCP plots the single case results for all cases of scenario
%   template scnTmp.
%
%   See aslo mkCP.

%%
task = @(cs) mkCP([],cs);
allCases(scnTmp,task);
%
end

