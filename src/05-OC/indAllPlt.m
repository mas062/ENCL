function [ ] = indAllplt(scn)
%INDALLPLT Index All Plots
%   indAllPLT(scn) runs rstInd2plt over all cases in scenario scn.
%
%   See also, rstInd2plt, clcPlt.

%%
allCases(scn,@task);
%
end
%
function [] = task(cs)
%%
rstInd2plt(cs);
%
end