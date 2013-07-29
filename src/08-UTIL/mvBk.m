function [status] = mvBk(pth)
%MVBK Move Back
%   mvBk(pth) takes the pth path address and moves the related folder from
%   the bkup disk to run directory. pth is the path from the project path.
%   
%   See also bkUp, apreRun.

%%
cmd = ['yes|cp -r ' bkDisk() pth ' ' enclDir() pth '../'];
[status result] = system(cmd);
if status ~= 0, 
    display(result); logIt(result); 
end
clear result;
end

