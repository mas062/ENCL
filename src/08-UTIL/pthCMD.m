function [cmd_path] = pthCMD(caseName)
%PTHCMD Path to CMD folder
%   cmd_path = pthCMD(caseName) returns the path to folder CMD which
%   includes the csh command files specific to case caseName.
%  
%   See also pthSCN, pthVIZ, pthPLT, pthRINC.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
cmd_path = [enclDir 'CLS/' cls '/' rlz '/' caseName '/CMD/'];

end

