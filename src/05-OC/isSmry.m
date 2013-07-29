function [yes_no] = isSmry(fN)
%ISSMRY Is Summary
%   isSmry(fN) return logical yes if fN is an Eclipse summary file and 
%   no if not.
%
%   See also .

%%
%
[p r s] = fileparts(fN);
yes_no =false;
%
smryCond = (length(s)==6) &&...
               (strcmp(s(1:2),'.A') ||strcmp(s(1:2),'.S')) && ...
               ~isempty(str2num(s(3:end)));
%
if smryCond, yes_no = true;end;
%
end

