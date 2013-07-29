function [rlzbD] = rlzbDir(rlz)
%RLZBDIR Realization Backup Directory
%   rlzbD(rlz) returns the path to rlz  backup realization directory.
%
%   See also clsbDir.

%%

rlzbD = [clsbDir(rlz2cls(rlz)) rlz '/'];

end

