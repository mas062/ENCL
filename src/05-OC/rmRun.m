function [] = rmRun(caseName)
%RMRUN Remove Run
%   rmRun(caseName) removes the files produced from the run in the running
%   directory and leaves the original model file.
%
%   See also rmRst, unzipRst, rmRstZip.

%%
%
msg = ['Removing Eclipse run result files for case ' caseName...
    ' from the local disk'];
display(msg);
logIt(msg);
%
rD = pthSCN(caseName);
if exist(rD,'dir'),
    cmd = ['ls ' rD '* | grep -v ' caseName '.DATA | xargs rm -rf'];
    system(cmd);
    %
    msg = ['Removing Eclipse run result files for case ' caseName...
        ' is done!'];
    display(msg);
    logIt(msg);
else
msg = ['No run directory for case ' caseName 'was found!'];
display(msg);
logIt(msg);
end    
%
end

