function [] = convEclDyn(caseName)
%CONVECLDYN Convert Eclipse Restart Data
%   convEclDyn(caseName) takes the case root name caseName and loads, 
%   converts and saves Eclipse restart outputs into a format available for 
%   plot and visualization in a .mat file with the same root name in the
%   VCT folder specific to the case.
%
%   See also convAllRst, mkRV.

%%
%clean the memory
if exist('rst','var'), clear rst;end
if exist('rst_raw','var'), clear rst_raw;end
%
msg = ['Converting Eclipse summary and restart output for case ' caseName];
display(msg);
logIt(msg);
%% Define variables
fN = [pthSCN(caseName) caseName];
rstChk = exist([fN '.FRSSPEC'],'file') && exist([fN '.FSMSPEC'],'file');
%
zN = [pthSCN(caseName) caseName '_RST.tar.gz'];
zipChk = exist(zN,'file');
%
fbN = [pthSCN(caseName) caseName];
rstbChk = exist([fbN '.FRSSPEC'],'file') && exist([fbN '.FSMSPEC'],'file');
%
zbN = [pthSCN(caseName) caseName '_RST.tar.gz'];
zipbChk = exist(zbN,'file');
%

%% Retart Path
% Find the path from which the restart files to be taken (or extracted
% from zip file if necessary).
%
if rstChk,  % non-zipped exist on the main disk
    FN = fN;
elseif rstbChk, % non-zipped exist on the backup disk
    FN = fbN;
elseif zipChk,  % zipped file exist on the main disk
    unzipRst(caseName);
    rememberToRemoveRestarts = true;
    FN = fbN;
elseif zipbChk, % zipped file exist on the backup disk
    unzipRst(caseName);
    rememberToRemoveRestarts = true;
    FN = fbN;
else
    FN = [];
end

%% Convert Eclipse Summary And Restarts
%
if ~isempty(FN),
    %--
    %
    [smry rst_raw] = readEclipseResults(FN,'files_out',false,...
        'RestartData', true);
%
    mkVCT(caseName);
% Summary
    fN_MAT = [pthVCT(caseName) caseName '_SMRY.mat'];
%
    save(fN_MAT, 'smry');clear smry;
%

% Restart
    rst = struct('times',rst_raw.TIME, ...
                 'PRESSURE', {rst_raw.PRESSURE},...
                 'SWAT', {rst_raw.SWAT}, ...
                 'FLOOILI', {rst_raw.FLOOILI}, ...
                 'FLOOILJ', {rst_raw.FLOOILJ}, ...
                 'FLOOILK', {rst_raw.FLOOILK}, ...
                 'FLOWATI', {rst_raw.FLOWATI}, ...
                 'FLOWATJ', {rst_raw.FLOWATJ}, ...
                 'FLOWATK', {rst_raw.FLOWATK}, ...
                 'timeindex', {rst_raw.ReportNo} ...
                 );
%
clear rst_raw;  
%
    fN_MAT = [pthVCT(caseName) caseName '_RST.mat'];
%
% Default M-File version must be set already to v7.3 from Preference
% window in command window menu.
    save(fN_MAT, 'rst');clear rst;
else
    msg = ['Restart or summary file(s) not found for ' caseName];
    display(msg);
    logIt(msg);
end
%
end
%






