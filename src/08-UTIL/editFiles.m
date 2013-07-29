function [] = editFiles()
allCases('SCN09',@task);
end
%
function [] = task(cs)
rlz = case2rlz(cs);
fN = [pthVAR(rlz) rlz '_EDIT.INC'];
fid = fopen(fN,'a');
fprintf(fid,'%s \n',' ');
fclose(fid);
end
