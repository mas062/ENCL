function [case_bpath] = casebDir(caseName)
%CASEBDIR Case Backup Directory
%   case_bpath = casebDir(caseName) returns the path to the backup case 
%   directory.
%
%   See also rlzbDir, clsbDir.

%%

case_bpath = [rlzbDir(case2rlz(caseName)) caseName '/'];

end

