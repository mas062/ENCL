function [cs] = col2cs(col,nd)
%COL2CS Collocation to Case Name
%   caseName = col2cs(col,nd) gives the corresponding case name for 
% collocation values col. nd is the uncertainty distribution version.
%
%   See also cs2col, scnT.

%% Load the MC Vector.
% Path to directory
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];

%% Load Collocation Points
cpN = [pN 'Cpoints_' num2str(nd) '.mat'];load(cpN);
br = Cpoints(1,end:-1:1);
ag = Cpoints(2,end:-1:1);
ft = Cpoints(3,:);
bw = Cpoints(4,:);
%% Initialize variables
%
cs = 'C12001_SC005_SCN00';
%
colind = [1 1 1 1];

%% Code Extraction
% SAIGUP Codes


for i =1:length(br),
    if  abs(br(i)-col(1))<0.001,
        colind(1) = i;
    end
end

for i =1:length(ag),
    if  abs(ag(i)-col(2))<0.001,
        colind(2) = i;
    end
end

for i =1:length(ft),
    if  abs(ft(i)-col(3))<0.001,
        colind(3) = i;
    end
end

for i =1:length(bw),
    if  abs(bw(i)-col(4))<0.001,
        colind(4) = i;
    end
end

%
cs(4) = num2str(colind(1));
cs(5) = num2str(colind(2));
scnC = strcat('SCN_',num2str(colind(3)),num2str(colind(4)),'.TMP');

%
%-% 
%
fid = fopen([pN 'tmp.lst'],'rt');
%
while ~feof(fid),
    lin = fgetl(fid);
    if lin==-1
        error('Problem in reading the template list file!');
    end
    SCN =[];
    if ~isempty(lin),
        scnL = textscan(lin,'%s');
        SCN = char(scnL{1}(1));
        scn = char(scnL{1}(3));
        if strcmp(scn,scnC),break;end
    end
end
fclose(fid);
%
if isempty(SCN), error('No scenario detected!');end
%

cs(end-1:end) = SCN(4:5);
%

end

