function [] = unziInit(caseName)
%UNZIPRST Unzip Init
%   unzipInit(caseName) unzipps the zipped restart files of case caseName
%   in SCN folder.
%
%   See also rmRst, rmRstZip.

%%
%
msg = ['Unzipping Eclipse restart files for case ' caseName];
display(msg);
logIt(msg);
%
zipN = [pthSCN(caseName) caseName '_RST.tar.gz'];
zipbN = [pthbSCN(caseName) caseName '_RST.tar.gz'];
%
if exist(zipN,'file'),
    ZN = zipN;
elseif exist(zipbN,'file'),
    ZN = zipbN;
else 
    ZN = [];
end
%
if ~isempty(ZN),
    %
    cmd = ['tar -ztf ' ZN ' --wildcards "*.FINIT"'];
    [st,rs] = system(cmd);
    %
    cmd = ['tar -C / -zxvf ' ZN];
    system(cmd);
    %
    rs = strtrim(rs);
    [pth nm ext] = fileparts(rs);
    %    
    cls = case2cls(caseName);
    rlz = case2rlz(caseName);
    %
    %crazy move
    %
    orgD = ['/' pth '/*.F*'];
    desD = pthbSCN(caseName);
    cmd = ['mv ' orgD ' ' desD];
    system(cmd);
    %
    msg = ['Unzipping Eclipse init file for  case ' caseName...
            ' is done!'];
    display(msg);
    logIt(msg);
else    
    msg = ['No zipped init file for case ' caseName 'was found!'];
    display(msg);
    logIt(msg);
end    
%
end

