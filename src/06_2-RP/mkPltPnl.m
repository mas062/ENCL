function [] = mkPltPnl(scnTmp)
%MKPLTPNL Make Plot Panel
%   mkPlotPnl(scnTmp) generates launchers for PLT folders of all cases
%   related to scenarion scnTmp.
%
%   See also mkPltLnch.

%%
%
allCases(scnTmp,@mkPltLnch);
%
end

