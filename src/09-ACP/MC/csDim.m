function [] = csDim(nd)
%CSDIM Eclipse Dimensional Runs
%   eclDim(bar,agr,fts,bkw) makes the scenario templates and the Eclipse
%   data files for the given collocation points in different dimensions.
%
%   See also inVar, fndCln.

%% Fixed Geological Dimensions
flt = '2';
lob = '2';
bar = 'v';
agr = 'v';
prg = '1';
dim = [flt;lob;bar;agr;prg];

%% Prepare Scenario Models
% Read scenario templates in a loop and do all the required steps to make
% Eclipse data files for those scenarios and different realizations

% Path to the scenario directories
pD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
psD = [pD 'ScnTmp/'];
%scnN = strcat(psD,scn);

plD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/Log/'];
pN = [plD 'acpRun.lst'];
cmd = ['rm ' pN];
system(cmd);

%       
% List of the template files
d = dir(psD); 
fid = fopen([pD 'tmp.lst'],'wt');
counter = 0;
for s=1:length({d.name}),
    scn = d(s).name;
    if ~isempty(strfind(scn,'.TMP')),
        counter = counter+1;
			% copy scenario template file to DATA/SCN_TMP
			SCN = ['SCN' num2str(10*(nd+1)-counter) '.TMP'];
			cmd = ['cp ' psD scn ' ' enclDir 'TMP/' SCN];
			system(cmd);
			%
			lin = [SCN ' -> ' scn];
			fprintf(fid,'%s \n',lin);
			%
    end
end
fclose(fid);
%
%% Generate polynomial bases
%
polyGen(nd)

% Preparing to report cases
plD = [pD 'Log/'];
if ~exist(plD,'dir'), system(['mkdir ' plD]);end
plN = [plD 'acpCase.lst'];
if exist(plN,'file'), system(['rm ' plN]);end


%% Load collocation point bases 
polyFile = [pD 'polynomial.mat'];
load(polyFile,'CollocationPointsBase');

for i=1:size(CollocationPointsBase,1),
    cs = col2cs(CollocationPointsBase(i,:),nd);
    scn = case2scn(cs);
    rlz = case2rlz(cs);
    ttlPblsh(scn);
    mkCase(scn,rlz);
    mkEcl(cs);
    logAcpCase(cs);
end

end
