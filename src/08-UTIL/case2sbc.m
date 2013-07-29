function [sbc] = case2sbc(caseName)
%CASE2SBC Case To Sub Class
%   case2sbc(caseName) returns the sub class name related to the given
%   case caseName.
%
%   See also case2scn, case2rlz, rlz2cls.

%%
%
sbc = caseName(8:12);
%
end