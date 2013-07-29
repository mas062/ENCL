function [cls] = case2cls(caseName)
%CASE2CLS Case To Class
%   case2cls(caseName) returns the class name related to the given
%   case caseName.
%
%   See also case2scn, case2rlz, rlz2cls.

%%
%
cls = caseName(1:end-12);
%
end