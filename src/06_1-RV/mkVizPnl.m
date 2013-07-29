function [] = mkVizPnl(scnTmp)
%MKVIZPNL Make Visualization Panel
%   mkVizPnl(scnTmp) generates launchers for VIZ folders of all cases
%   related to scenarion scnTmp.
%
%   See also mkVizLnch.

%%
%
allCases(scnTmp,@mkVizLnch);
%
end

