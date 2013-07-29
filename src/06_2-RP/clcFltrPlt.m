function [] = clcFltrPlt(scnTmp,dim,sbc)
%CLCFLTRPLT Calculate Filtered Plot Vectors
%   clcFltrPlt(scnTmp,dim,sbc) takes the scenario template scnTmp and produces 
%   the plot vectors for filtered realization runs on that scenario.
%
%   See also clcPlt, fltrCases.

%%
% task = @(cs) clcPlt(cs);
fltrCases(scnTmp,@task,dim,sbc);
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
