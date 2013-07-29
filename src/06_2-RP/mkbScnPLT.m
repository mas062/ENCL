function [] = mkbScnPLT(scn)
%MKBSCNPLT Make Backup Scenario PLT folder
%   mkbScnPLT(scn) makes the PLT folder which is to contain result
%   figures of line plots for the run which is specific to cases for
%   scenario scn.
%
%   See also mkSCN, mkPLT.

%%
% Check for PLT folder
scnPltD = [bkDisk 'PLT/PLT_' scn '/'];
if ~exist(scnPltD,'dir'),
    cmd = ['mkdir ' scnPltD];
    system(cmd);
end
end
