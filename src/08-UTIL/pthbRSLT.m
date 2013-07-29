function [rslt_bpath] = pthbRSLT(caseName)
%PTHRSLT Path to RSLT folder
%   rslt_path = pthRSLT(caseName) returns the path to folder RSLT which
%   contains folders of run results for the case caseName.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
rslt_bpath = [bkDisk 'CLS/' cls '/' rlz '/' caseName '/RSLT/'];

end

