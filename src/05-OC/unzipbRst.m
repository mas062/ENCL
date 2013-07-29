function [] = unzipbRst(caseName)
%UNZIPRST Unzip Restarts
%   unzipRst(caseName) unzipps the zipped restart files of case caseName
%   in SCN folder.
%
%   See also rmRst, rmRstZip.

%%
%
msg = ['Unzipping Eclipse restart files for case ' caseName];
display(msg);
logIt(msg);
%
zipN = [pthbSCN(caseName) caseName '_RST.tar.gz'];
if exist(zipN,'file'),
    cmd = ['tar -C / -zxvf ' zipN];
    system(cmd);
    %
    msg = ['Unzipping Eclipse restart files for case ' caseName ' is done!'];
    display(msg);
    logIt(msg);
else
msg = ['No zipped restart files for case ' caseName 'was found!'];
display(msg);
logIt(msg);
end    
%
end

