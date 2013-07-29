function [plt_path] = pthPLT(caseName)
%PTHPLT Path to PLT folder
%   plt_path = pthPLT(caseName) returns the path to folder PLT which
%   contains line plot figures of caseName run results.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
plt_path = [enclDir 'CLS/' cls '/' rlz '/' caseName '/RSLT/PLT/'];

end

