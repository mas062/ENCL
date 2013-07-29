function [pathb_scnPLT] = pthbScnPLT(scn)
%PTHSCNPLT Path To Scenario PLT Folder
%   [pathb_scnPLT] = pthbScnPLT(scn) takes scn scenario name and returns the
%   path to the PLT folder in SCN_PLT directory.
%
%   See also mkScnPLT, savePltFig.

%%
pathb_scnPLT = [bkDisk 'PLT/PLT_' scn '/'];
%
end

