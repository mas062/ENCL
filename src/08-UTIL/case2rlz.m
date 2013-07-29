function [rlz] = case2rlz(caseName)
%CASE2RLZ Case To Realization  
%   case2rlz(caseName) returns the realization name related to the given
%   case caseName.
%
%   See also case2scn, case2cls, rlz2cls.

%%
%
rlz = ['R_' caseName(1:end-6)];
%
end

