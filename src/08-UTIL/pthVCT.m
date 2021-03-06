function [vct_path] = pthVCT(caseName)
%PTHVCT Path to VCT folder
%   vct_path = pthVCT(caseName) returns the path to folder VCT which
%   contains converted vectors of caseName run results.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
vct_path = [caseDir(caseName) 'RSLT/VCT/'];

end

