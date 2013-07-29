function [ ] = monitorVCT(scn)
%MONITORVCT Monitor VCT Folders
%   [ ] = monitorVCT(scn,sbc) takes record of file vectors in VCT folders and
%   returns vectors of 0 and 1 in a file in the LOG directory. This is done
%   for scenario scn.
%
%   See also existVct.

%%
global vct;
%
fN = [enclDir 'LOG/' scn '_vct.lst'];
%
[fid msg] = fopen(fN,'w+');
%
vct = {'GRD';'INIT';'SMRY';'RST';'PLT';'EORST'};
lin = ['CASE               ' reshape(char(vct)',1,30)];
fprintf(fid,'%s \n',lin);

%%
h =@(x) task(x,fid);
allCases(scn,h);
%
fclose(fid);
%
end
function [] = task(caseName,fid)
global vct;
%
lin = existVct(caseName,vct{:});
fprintf(fid,'%s ',[caseName ' ']);
fprintf(fid,'%i ',lin');
fprintf(fid,'%s \n', '');
%
end
