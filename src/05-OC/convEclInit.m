function [ ] = convEclInit(caseName )
%CONVECLINIT Convert Eclipse Init Data
%   convEclInit(caseName) takes the case root name caseName and loads, 
%   converts and saves the Eclipse Init outputs into a format available 
%   for plot and visualization in a .mat file with the same root name in
%   VCT folder.
%
%   See also convAllInit, mkRP, mkRV.

%%
%
msg = ['Converting Eclipse INIT file for case ' caseName];
display(msg);
logIt(msg);

% Load INIT file
fN_INIT = [pthSCN(caseName) caseName '.FINIT'];
% chkInit = exist(fN_INIT,'file');
% 
% zN = [pthSCN(caseName) caseName '_RST.tar.gz'];
% zipChk = exist(zN,'file');
% 
% zbN = [pthSCN(caseName) caseName '_RST.tar.gz'];
% zipbChk = exist(zN,'file');
% %
% if ~chkInit,
%     unzipRst(caseName);
% end

%

if exist(fN_INIT,'file')
    init = readEclipseOutput(fN_INIT);
% Save to mat file
    mkVCT(caseName);
    fN_MAT = [pthVCT(caseName) caseName '_INIT.mat'];
    save(fN_MAT,'init');
else
    msg = ['INIT file not found for ' caseName];
    display(msg);
    logIt(msg);
end
end

