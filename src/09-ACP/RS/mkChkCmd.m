function [] = mkChkCmd(nd)
%MKCHKCMD Make Check Eclipse
%   mkChkCmd(nd) makes eclipse cases to be checked with polynomial approximations.
%
%   See also .

%% Loop Over Cases
pD = [enclDir 'ACP/' num2str(nd) '/'];
system(['mkdir ' pD 'Cmd/']);
pcN = [pD 'Cmd/acpChkCmd.lst'];
cid = fopen(pcN,'wt');

%Load workspace variables
cssFile = [pD 'chkCss.mat'];
load(cssFile,'css');

for c=1:length(css),
	cs = css{c};
	% Check for the cases run situation
	notRun = ~runOk(cs);
	%% Write Out Commands
	% Write commands in a seperate file.
	cmd = ['sh ' pthCMD(cs) cs '.csh'];
	if notRun, fprintf(cid,'%s \n',cmd);end
	%
end
fclose(cid);
end
