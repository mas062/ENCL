function [] = cmrPlt(nd)
%CMRPLT Compare Plots
%   cmrPlt(nd) plots the comparison curves for Eclipse runs and polynomial approximations.
%
%   See also chkCs, polyCase.

%%
prop = { 'FPR'...
			'totMobCo2'...
			'totResCo2'...
			'largestPlume'...
			'meanPlume'...
			'WBHP'...
			'plumeNum'...
			'leakageRisk'...
			};
			
pD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
polyFN = [pD 'polynomial.mat'];
%
cs = [];
load(polyFN,'CollocationPointsBase','P');
for c=1:P,
	cs{end+1} = col2cs(CollocationPointsBase(c,:),nd);
end
%
chkFN = [pD 'chkCss.mat'];
load(chkFN,'css')
for c=1:length(css),
	cs{end+1} = css{c};
end
%

for pr = 1:length(prop),
	counter = 0;
	for c = P:P+2,
		counter = counter+1;
		chkCs(prop{pr},cs{c},num2str(counter));
	end
end
end



