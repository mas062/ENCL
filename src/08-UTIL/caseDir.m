function [case_path] = caseDir(caseName)
%CASEDIR Case Directory
%   case_path = caseDir(caseName) returns the path to the case directory.
%
%   See also rlzDir, clsDir.

%%

case_path = [rlzDir(case2rlz(caseName)) caseName '/'];

end

