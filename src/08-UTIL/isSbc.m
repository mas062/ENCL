function [yes_no] = isSbc(sbc)
%ISSBC Is Subclass
%   isSbc(sbc) returns true if sbc is a valid subclass name and false
%   if it is not.
%
%   See also isRlz, isCls, isCase.

%%
yes_no = false;
idn = ~isempty(str2num(sbc(3:end))); 
%
sbcCond = (length(sbc)==5) && ...
            strcmp(sbc(1:2),'SC') && ...
            idn;
if sbcCond, yes_no = true; end
%
end

