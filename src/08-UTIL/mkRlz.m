function [] = mkRlz()
%MKRLZ Make Realization Folders
%   mkRlz() makes the realization folders in the classes.
%
%   See also mkRL.

%%
% File of realizations list
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
        cls = rlz2cls(rlz);
        if ~exist(clsDir(cls),'dir'), 
            cmd = ['mkdir ' clsDir(cls)];
            system(cmd);
        end
        if ~exist(rlzDir(rlz),'dir'), 
            cmd = ['mkdir ' rlzDir(rlz)];
            system(cmd);
        end        
    end
end 
fclose(fid);      

end

