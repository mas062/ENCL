function [cls] = rlz2cls(rlz)
%RLZ2CLS Realization To Class
%   rlz2cls(rlz) returns the class name related to the given
%   realization rlz.
%
%   See also case2scn, case2rlz, case2cls.

%%
%
cls = rlz(3:end-6);

%
end