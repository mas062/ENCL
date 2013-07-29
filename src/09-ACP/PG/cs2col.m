function [varVal,varInd] = cs2col(cs)
%CS2COL Case to Collocation
%   col = cs2col(cs) gives the corresponding collocation values for the case name
%   cs. 
%
%   See also scnT.
%% Load the MC Vector.
% Path to directory
nds = cs(end-1);
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' nds '/'];
cN = [pN 'Cpoints_' nds '.mat'];
%% Load Collocation Points
load(cN);
brr = Cpoints(1,:);
agr = Cpoints(2,:);
fts = Cpoints(3,:);
bkw = Cpoints(4,:);

%% Code Extraction
% SAIGUP Codes
%
brInd = str2num(cs(4));
agInd = str2num(cs(5));
%
%-% 
%
fid = fopen([pN 'tmp.lst'],'rt');
itIsClosed = false;
%
while ~feof(fid),
    lin = fgetl(fid);
    if lin==-1
        error('Problem in reading the template list file!');
    end
    scn =[];
    if ~isempty(lin),
        scnL = textscan(lin,'%s');
        SCN = char(scnL{1}(1));
        scn = char(scnL{1}(3));
        if strcmp(case2scn(cs),SCN(1:5)),
        fclose(fid); itIsClosed = true;
        break;end
    end
end
%
if ~itIsClosed,fclose(fid);end
%
if isempty(scn), error('No scenario detected!');end
%
% Fault Transmissibility Codes
ftInd = str2num(scn(5));
%
% Boundary Condition Codes
bwInd = str2num(scn(6));
%db
% Physical Codes

% Operational Codes


%% Return Values

brVal = brr(4-brInd);
agVal = agr(4-agInd);
ftVal = fts(ftInd);
bwVal = bkw(bwInd);

varInd = [brInd;agInd;ftInd;bwInd];
varVal = [brVal;agVal;ftVal;bwVal];
%

end

