function [] = zipbRst(caseName)
%ZIPRST Zip Restarts
%   zipRst(caseName) zipps the restart files of case caseName in SCN
%   folder.
%
%   See also rmRst.

%%
%
rstbN = [pthbSCN(caseName) caseName '.F*'];
%
msg = ['Zipping b-restart files for case ' caseName '...'];
display(msg);
logIt(msg);
% 
zipbN = [pthbSCN(caseName) caseName '_RST.tar.gz'];
cmd = ['tar zcvf ' zipbN ' ' rstbN];
system(cmd);
%
msg = ['Done! with zipping b-restart files for case ' caseName '...'];
display(msg);
logIt(msg);
% 
end

