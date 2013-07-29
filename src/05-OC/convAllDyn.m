function [] = convAllDyn(scnTmp)
%CONVALLDYN Convert All Dynamic Data
%   convAllDyn(scnTmp) loads and converts Eclipse dynamic outputs for all the
%   realizations into a format available for plots and visualization. Data
%   related to runs of scenario template scnTmp are used.
%
%   See also convEclDyn, mkRP, mkRV.

%%
%

h = @(x) task(x);
allCases(scnTmp,h);
%                        
end
function task(cs)
pth = pthVCT(cs);
load([pth cs '_SMRY.mat']);
wbhp = smry.WBHP(2)
notDone = wbhp>400;
if notDone, convEclDyn(cs);end
end
