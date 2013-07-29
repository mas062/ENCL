function [] = rmVCT(caseName)
%RMVCT Remove Run
%   rmVCT(caseName) removes the run result vector files inside VCT folder.
%   This includes all the converted and calculated vector files in mat
%   format.
%
%   See also rmRst, unzipRst, rmRstZip.

%%
%
msg = ['Removing VCT files for case ' caseName...
    ' from the local disk'];
display(msg);
logIt(msg);
%
vD = pthVCT(caseName);
if exist(vD,'dir'),
    cmd = ['rm ' vD '*.mat'];
    system(cmd);
    %
    msg = ['All mat vector files are removed for case ' caseName...
        '.'];
    display(msg);
    logIt(msg);
else
msg = ['No VCT directory for case ' caseName 'was found!'];
display(msg);
logIt(msg);
end    
%
end

