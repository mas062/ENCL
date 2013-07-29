function [] = convAllSmry(scnTmp)
%CONVALLSMRY Covert All Summeries
%  convAllSmry(scnTmp) takes the scenario template name scnTmp and
%  converts the summary files for all cases in mat-files in the run
%  directories.
%
%  See also convEclSmry, convEclData, convAllEcl.

%%
%
h = @(x) convEclSmry(x);
allCases(scnTmp,h);
%
end

