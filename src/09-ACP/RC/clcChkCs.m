function [] = clcChkCs(nd)
%CLCCHKCS Calculate Check Case
%  clcChkCs(nd) calculates checking cases plot vectors.
% 
%   See also polyCase, polyTune, polyGen, rspVct, clcAcpPlt.
%%

nds = num2str(nd);

%% List of cases
ncs = 10;
% Load list of Collocations
pN = [enclDir 'ACP/' nds '/'];
load([pN 'chkCss.mat'],'css');

for c=1:length(ncs),
	cs = css{c};
	%
	
	if runOk(cs),%~exist([pthVCT(cs) cs '_PLT.mat'],'file')*runOk(cs),
		clcPlt(cs);
		%
		pltClcDone(cs);
		%
		zipRst(cs);
		%
		rmRst(cs);
	end	
   %
end
	
end


