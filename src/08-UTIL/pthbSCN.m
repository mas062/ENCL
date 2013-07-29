function [scn_bpath] = pthbSCN(caseName)
%PTHBSCN Path to Backup SCN folder
%   scn_path = pthbSCN(caseName) returns the path to backup folder SCN 
%   which includes the run files specific to case caseName.
%  
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%

scn_bpath = [casebDir(caseName) 'SCN/'];

end
