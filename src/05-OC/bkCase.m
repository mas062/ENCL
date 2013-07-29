function [status] = bkCase(caseName)
%BKCASE Back Up Case
%   bkCase(caseName) makes a copy of the SCN folder for the case caseName
%   into the backup disk.
%
%   See also bkDisk.

%%
%
msg = ['Making a run result backup for case ' caseName '.'];
display(msg);
logIt(msg);
%
mkbCsDir(caseName);
%
pth = strrep(caseDir(caseName),enclDir(),'');
%
status = bkUp(pth);
%
if status == 0, 
    msg = ['Run result backup for case ' caseName 'exist now.'];
    display(msg);
    logIt(msg);
end
%

end

