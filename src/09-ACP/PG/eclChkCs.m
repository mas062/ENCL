function [] = eclChkCs(nd)
%ECLCHKCS Eclipse Check Case
%  chkCs(prop,cs) checks polynomial approximation of response prop for cs.
% 
%   See also polyCase, polyTune, polyGen, rspVct, clcAcpPlt.
%%

nds = num2str(nd);

%% List of cases

% Load list of Collocations
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' nds '/'];
polyF = [pN 'polynomial.mat'];
load(polyF,'SortUniqueCombinations','P');

Nc = size(SortUniqueCombinations,1);
css = [];

%% Run cases
%
pD = [enclDir 'ACP/' num2str(nd) '/'];
system(['mkdir ' pD 'Cmd/']);
pcN = [pD 'Cmd/acpChkCmd.lst'];
cid = fopen(pcN,'wt');
nruns = 10;
for c= P+1:P+nruns,
	css{end+1} = col2cs(SortUniqueCombinations(c,:),nd);

	% Check for the cases run situation
	notRun = ~runOk(css{c-P});
	
	% Write out command flile for cases in their CMD directory
	mkEcl(css{c-P});
	
	%% Write Out Commands
	% Write commands in a seperate file.
	cmd = ['sh ' pthCMD(css{c-P}) css{c-P} '.csh'];
	if notRun, fprintf(cid,'%s \n',cmd);end
	%
end
fclose(cid);
save([pN 'chkCss.mat'],'css');
	
end


