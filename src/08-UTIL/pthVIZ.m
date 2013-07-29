function [viz_path] = pthVIZ(caseName)
%PTHVIZ Path to VIZ folder
%   viz_path = pthVIZ(caseName) returns the path to folder VIZ which
%   contains visualiztion figures of caseName run results.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD, pthRPT.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
viz_path = [enclDir 'CLS/' cls '/' rlz '/' caseName '/RSLT/VIZ/'];

end

