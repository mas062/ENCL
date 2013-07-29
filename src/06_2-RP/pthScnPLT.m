function [path_scnPLT] = pthScnPLT(scn)
%PTHSCNPLT Path To Scenario PLT Folder
%   [path_scnPLT] = pthScnPLT(scn) takes scn scenario name and returns the
%   path to the PLT folder in SCN_PLT directory.
%
%   See also mkScnPLT, savePltFig.

%%
path_scnPLT = [enclDir 'PLT/PLT_' scn '/'];
%
end

