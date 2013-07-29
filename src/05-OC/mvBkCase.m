function [status] = mvBkCase(caseName)
%MVBKCASE Move Back Case
%   mvBkCase(caseName) makes a copy of the SCN folder for the case caseName
%   into the backup disk.
%
%   See also bkDisk.

%%
%
msg = ['Moving back run result backup for case ' caseName '.'];
display(msg);
logIt(msg);
%
mkbCsDir(caseName);
%
pth = strrep(casebDir(caseName),bkDisk(),'');
%
status = mvBk(pth);
%
if status == 0, 
    msg = ['Moving back the ' caseName ' is done!'];
    display(msg);
    logIt(msg);
    cmd = ['rm -r ' casebDir(caseName)];
    system(cmd);
end
%

end

