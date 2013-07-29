function [] = clcAllPlt(scnTmp)
%CLCALLPLT Calculate All Plot Vectors
%   clcAllPlt(scnTmp) takes the scenario template scnTmp and produces 
%   the plot vectors for all realization runs on that scenario.
%
%   See also clcPlt.

%%
% task = @(cs) clcPlt(cs);
allCases(scnTmp,@task);
%
end
%
function [] = task(cs)
%%
if doPltClc(cs),
    %
    clcPlt(cs);
    %
    pltClcDone(cs);
    %
    zipRst(cs);
    %
    rmRst(cs);
    %
else 
    display(['No need to clcPlt for  case ' cs]);
end
%
end