function [] = dataClass()
%DATACLASS Data Classification Function
%   dataClass() takes the list of files to be classified from
%   realizations lst file and looks for those files in the
%   realization storage folder(RS). It extracts the variational keywords
%   and fills in VAR folders for each subclass.
%
%   See also mkRL, mkScn.

%%
%
msg = ['Extracting keywords from realizations.'];
display(msg);
logIt(msg);
%
% Full file name
fN = [enclDir 'DATA/RS/realizations.lst'];
fid = fopen(fN,'r');
while ~feof(fid)
    lin = fgetl(fid);
    if lin~=-1
%    Extracts the realization file root name from the current line of
%    the file
        sn = textscan(lin,'%s');
        fN = char(sn{1});
        [p rlz e] =fileparts(fN);
%     Makes the directory for keyword extraxtion
        mkVAR(rlz);
        rdN = [pthVAR(rlz) rlz];
%     Extracts keywords
        fNIn = [enclDir 'DATA/RS/' fN];
        kwExt(fNIn,rdN);
    end
end 
fclose(fid);      
end




