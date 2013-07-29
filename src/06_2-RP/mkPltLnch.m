function [] = mkPltLnch(caseName)
%MKPLTLNCH Make Plot Launcher
%   mkPltLnch(caseName) takes the caseName and makes a launcher for its
%   plot folder. The target is put PANEL/PLT/ .
%
%   See also mkPltPnl.

%%
pltPth = pthPLT(caseName);
scn = case2scn(caseName);
if exist(pltPth,'dir'),
    pnlPLTpth = [enclDir '/DATA/PANEL/PLT/'];
    pnlScnPLT = [enclDir '/DATA/PANEL/PLT/' scn '/'];
%
    if ~exist(pnlPLTpth,'dir'),
        cmd = ['mkdir ' pnlPLTpth];
        system(cmd);
    end
%
    if ~exist(pnlScnPLT,'dir'),
        cmd = ['mkdir ' pnlScnPLT];
        system(cmd);
    end
%
    cmd = ['ln -s ' pltPth ' ' pnlScnPLT caseName];
    system(cmd);
else
    display(['no plot forlder available for case ' caseName '.']);
end
%
end

