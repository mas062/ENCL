function [] = zipRst(caseName)
%ZIPRST Zip Restarts
%   zipRst(caseName) zipps the restart files of case caseName in SCN
%   folder.
%
%   See also rmRst.

%%
%
rstN = [pthSCN(caseName) caseName '.F*'];
%
msg = ['Zipping restart files for case ' caseName '...'];
display(msg);
logIt(msg);
% 
zipN = [pthSCN(caseName) caseName '_RST.tar.gz'];
cmd = ['tar zcvf ' zipN ' ' rstN];
system(cmd);
%
msg = ['Done! with zipping restart files for case ' caseName '...'];
display(msg);
logIt(msg);
% 
end

