function [yes_no] = isRst(fN)
%ISRST Is Restart
%   isRst(fN) return logical yes if fN is an Eclipse restart file and no if
%   not.
%
%   See also .

%%
%
[p r s] = fileparts(fN);
yes_no =false;
%
rstCond = (length(s)==6) &&...
               (strcmp(s(1:2),'.F') ||strcmp(s(1:2),'.X')) && ...
               ~isempty(str2double(s(3:end)));
%
if rstCond, yes_no = true;end;
%
end

