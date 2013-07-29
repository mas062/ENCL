function [rlzD] = rlzDir(rlz)
%RLZDIR Realization Directory
%   rlzD(rlz) returns the path to rlz realization directory.
%
%   See also clsDir.

%%

rlzD = [clsDir(rlz2cls(rlz)) rlz '/'];

end

