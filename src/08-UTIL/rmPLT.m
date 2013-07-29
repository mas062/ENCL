function [] = rmPLT(caseName)
%RMPLT Remove Plot File
%   rmPLT(caseName) removes the run result plot vector file inside VCT folder.
%
%   See also rmVCT, rmRst, unzipRst, rmRstZip.

%%
%
msg = ['Removing PLT file for case ' caseName...
    ' from the local disk'];
display(msg);
logIt(msg);
%
vD = pthVCT(caseName);
if exist(vD,'dir'),
    cmd = ['rm ' vD caseName '_PLT.mat'];
    system(cmd);
    %
    msg = ['PLT mat vector file is removed for case ' caseName...
        '.'];
    display(msg);
    logIt(msg);
else
msg = ['No VCT directory for case ' caseName ' was found!'];
display(msg);
logIt(msg);
end    
%
end

