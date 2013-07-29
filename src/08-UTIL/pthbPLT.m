function [plt_path] = pthbPLT(caseName)
%PTHBPLT Back-up Path to PLT folder
%   plt_path = pthbPLT(caseName) returns the path to folder PLT which
%   contains line plot figures of caseName run results.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
plt_path = [bkDisk 'CLS/' cls '/' rlz '/' caseName '/RSLT/PLT/'];

end

