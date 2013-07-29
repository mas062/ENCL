function [status] = bkUp(pth)
%BKUP Back Up
%   bkUp(pth) takes the pth path address and makes a back up of that into
%   the back up disk. pth is the path from the project path given by 
%   enclDir() function.
%   
%   See also apreRun.

%%
cmd = ['yes|cp -r ' enclDir() pth ' ' bkDisk() pth '../'];
[status result] = system(cmd);
if status ~= 0, 
    display(result); logIt(result); 
end
clear result;
end

