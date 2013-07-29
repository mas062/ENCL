function [] = zipRst_test(caseName)
%ZIPRST Zip Restarts
%   zipRst(caseName) zipps the restart files of case caseName in SCN
%   folder.
%
%   See also rmRst.

%%
%
rstN = [pthbSCN(caseName) caseName '.F*'];
%
msg = ['Zipping restart files for case ' caseName '...'];
display(msg);
logIt(msg);
% 
pAdd = pwd;
cmd = ['cd ' pthbSCN(caseName)];system(cmd);
%
zipN = [ caseName '_RST.tar.gz'];
cmd = ['tar zcvf ' zipN ' ' rstN];
system(cmd);
%
cmd = ['cd ' pAdd];system(cmd);
%
msg = ['Done! with zipping restart files for case ' caseName '...'];
display(msg);
logIt(msg);
% 
end

