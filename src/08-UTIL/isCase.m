function [yes_no] = isCase(caseName)
%ISCASE Is Case
%   isCase(caseName) returns true if caseName is in case format and false
%   if it is not.
%
%   See also .

%%
yes_no = false;
%
caseCond = (length(caseName)==18) && ...
            isCls(caseName(1:6)) && ...
            strcmp(caseName(7),'_') && ...
            isSbc(caseName(8:12)) && ...
            strcmp(caseName(13),'_') && ...
            isScn(caseName(14:end));
%
if caseCond, yes_no = true; end
%
end

