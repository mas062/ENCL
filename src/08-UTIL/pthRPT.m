function [rpt_path] = pthRPT(caseName)
%PTHRPT Path to RPT folder
%   rpt_path = pthRPT(caseName) returns the path to folder RPT which
%   includes the report files specific to case caseName.
%  
%   See also pthSCN, pthVIZ, pthPLT, pthRINC, pthCMD.

%%
rlz = case2rlz(caseName);
cls = rlz2cls(rlz);
rpt_path = [enclDir 'CLS/' cls '/' rlz '/' caseName '/RPT/'];

end

