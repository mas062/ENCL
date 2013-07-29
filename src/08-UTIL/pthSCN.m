function [scn_path] = pthSCN(caseName)
%PTHSCN Path to SCN folder
%   scn_path = pthSCN(caseName) returns the path to folder SCN which
%   includes the run files specific to case caseName.
%  
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%

scn_path = [caseDir(caseName) 'SCN/'];

end

