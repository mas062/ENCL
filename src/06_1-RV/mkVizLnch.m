function [] = mkVizLnch(caseName)
%MKVIZLNCH Make Visualization Launcher
%   mkVizLnch(caseName) takes the caseName and makes a launcher for its
%   visualization folder. The target is put PANEL/VIZ/ .
%
%   See also mkVizPnl.

%%
vizPth = pthVIZ(caseName);
scn = case2scn(caseName);
if exist(vizPth,'dir'),
    pnlVIZpth = [enclDir '/DATA/PANEL/VIZ/'];
    pnlScnVIZ = [enclDir '/DATA/PANEL/VIZ/' scn '/'];
%
    if ~exist(pnlVIZpth,'dir'),
        cmd = ['mkdir ' pnlVIZpth];
        system(cmd);
    end
%
    if ~exist(pnlScnVIZ,'dir'),
        cmd = ['mkdir ' pnlScnVIZ];
        system(cmd);
    end
%
    cmd = ['ln -s ' vizPth ' ' pnlScnVIZ caseName];
    system(cmd);
else
    display(['no visualization forlder available for case ' caseName '.']);
end
%
end

