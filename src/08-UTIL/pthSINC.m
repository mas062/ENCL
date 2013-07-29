function [sinc_path] = pthSINC(caseName)
%PTHSINC Path to SINC folder
%   sinc_path = pthSINC(caseName) returns the path to folder SINC which
%   contains files to be included in Eclipse model specific to case
%   caseName.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
sinc_path = [enclDir 'CLS/' cls '/' rlz '/' caseName '/SINC/'];

end

