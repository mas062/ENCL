function [sinc_bpath] = pthbSINC(caseName)
%PTHBSINC Back-up Path to SINC folder
%   sinc_bpath = pthbSINC(caseName) returns the path to folder SINC which
%   contains files to be included in Eclipse model specific to case
%   caseName. This is done on the back-up disk.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
sinc_bpath = [bkDisk 'CLS/' cls '/' rlz '/' caseName '/SINC/'];

end

