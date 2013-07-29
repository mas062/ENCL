function [] = mkRL()
%MKRL Make Realization List
%   mkRL returns list of the realizations to be used in the scenario
%   construction procedure and prints the output into a file in
%   realization storage folder(RS). This file will be used in dataClass
%   function.
%
%   See also dataClass, mkScn.

%%
msg = ['Making realization list.'];
display(msg);
logIt(msg);
%
% Path to the storage directory
dN = [enclDir 'RS/'];
dL = dir(dN);
% Filename in which the list will be printed
lN = [dN 'realizations.lst'];

fid = fopen(lN,'w');
for i=1:length(dL)
    fName = char(dL(i).name);
    [pth rlz ext] = fileparts(fName);
    if isRlz(rlz),
        fprintf(fid,'%s \n',[rlz '.grdecl']);
    end
end
fclose(fid);
end