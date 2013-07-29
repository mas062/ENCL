function [] = rmRstZip(caseName)
%RMRSTZIP Remove Restart Zipped File
%   rmRstZip(caseName) removes the zipped restart files of case caseName
%   in SCN folder.
%
%   See also rmRst, unzipRst.

%%
%
msg = ['Removing Eclipse restart files for case ' caseName...
    ' from the local disk'];
display(msg);
logIt(msg);
%
zipN = [pthSCN(caseName) caseName '_RST.tar.gz'];
if exist(zipN,'file'),
    cmd = ['rm ' zipN];
    system(cmd);
    %
    msg = ['Removing Eclipse restart zipped file for case ' caseName...
        ' is done!'];
    display(msg);
    logIt(msg);
else
msg = ['No zipped restart files for case ' caseName ' was found!'];
display(msg);
logIt(msg);
end    
%
end

