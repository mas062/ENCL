function [] = eclDim(nd)
%ECLDIM Eclipse Dimensional Runs
%   eclDim(bar,agr,fts,bkw) makes the scenario templates and runs Eclipse
%   data files for the given collocation points in different dimensions.
%
%   See also inVar, fndCln.

%% Fixed Geological Dimensions
flt = '2';
lob = '2';
bar = 'v'
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

% List of the template files
d = dir(psD); 
fid = fopen([pD 'ranScn.lst'],'wt');
counter = 0;
for s=1:length({d.name}),
    scn = d(s).name;
    if ~isempty(strfind(scn,'.TMP')),
        counter = counter+1;
%         fsi=str2num(scn(5));
%         bwi=str2num(scn(6));
        SCN = ['SCN' num2str(10*(nd+1)-counter) '.TMP'];
        runFltrEcl(SCN,dim,'SC005');
        lin = [SCN ' -> Done!'];
        fprintf(fid,'%s \n',lin);
    end
end
fclose(fid);

end
