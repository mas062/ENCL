function [yes_no] = isScn(scn)
%ISSCN Is Scenario
%   isScn(scn) returns true if scn is a valid scenario name and false if it
%   is not.
%
%   See also isCls, isCase, isRlz, isSbc.

%%
yes_no = false;
idn = ~isempty(str2num(scn(4:end))); 
%
scnCond = (length(scn)==5) && ...
            strcmp(scn(1:3),'SCN') && ...
            idn;
if scnCond, yes_no = true; end
%



end

