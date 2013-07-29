function [yes_no] = isRlz(rlz)
%ISRLZ Is Realization
%   isRlz(rlz) returns true if rlz is a valid realization name and false
%   if it is not.
%
%   See also isSbc, isCls, isCase.

%%
yes_no = false;
%
rlzCond = (length(rlz)==14) && ...
            strcmp(rlz(1:2),'R_') && ...
            isCls(rlz(3:8)) && ...
            strcmp(rlz(9),'_') && ...
            isSbc(rlz(10:end));
%
if rlzCond, yes_no = true; end
%
end

