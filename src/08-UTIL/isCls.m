function [yes_no] = isCls(cls)
%ISCLS Is Class
%   isCls(cls) returns true if cls is a valid class name and false
%   if it is not.
%
%   See also .

%%
yes_no = false;
idn = ismember(cls(2),['0','1']); 
for i=3:6,
    idn = idn*ismember(cls(i),['1','2','3']);
end
clsCond = (length(cls)==6) && ...
            strcmp(cls(1),'C') && ...
            idn;
if clsCond, yes_no = true; end

end

