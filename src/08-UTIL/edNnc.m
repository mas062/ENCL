function [] = edNnc(rlz)
%EDNNC Edit NNC 
%   temporary used function to separate the EDITNNC keywords from SATNUM
%   files.

%%
satF = [pthVAR(rlz) rlz '_SATNUM.INC'];
edF = [pthVAR(rlz) rlz '_EDIT.INC'];
aa = [pthVAR(rlz) rlz '_aa.INC'];
%
cmd = ['cp -r ' satF ' ' edF];
system(cmd);
%
cmd = ['cp -r ' satF ' ' aa];
system(cmd);
%
fid = fopen(aa,'r+');
fjd = fopen(satF,'w+');
fkd = fopen(edF,'w+');
%
isSat = true;
while ~feof(fid),
    lin = fgetl(fid);
    isSat = isSat & isempty(regexp(lin, 'EDITNNC', 'match', 'once'));
    if isSat,
        fprintf(fjd,'%s \n',lin);
    else
        fprintf(fkd,'%s \n',lin);
    end
end
fclose(fid);
fclose(fjd);
fclose(fkd);
%
cmd = ['rm ' aa];
system(cmd);
%
end

