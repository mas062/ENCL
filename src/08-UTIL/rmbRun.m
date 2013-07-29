function [] = rmbRun(caseName)
%RMBRUN Remove Backup Run
%   rmbRun(caseName) removes the files produced from the run in the running
%   directory on the backup disk and leaves the original model file.
%
%   See also rmRun, rmRst, unzipRst, rmRstZip.

%%
%
reply = input(['Not funny at all! Are you sure...?'...
    ' You are removing the back up data!!! yes/no [no]: '], 's');
if isempty(reply)
    reply = 'no';
end
reply = input(['I am crazy to make this function.'...
    ' Are you joining the club to use it!!! yes/no [no]: '], 's');
if isempty(reply)
    reply = 'no';
end
%
if strmatch('yes',reply),
    msg = ['Removing Eclipse backed up run result files for case ' caseName...
        ' from the local disk'];
    display(msg);
    logIt(msg);
    %
    rD = pthbSCN(caseName);
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
else
    display('Velkomen tilbake ;-)')
end
end

