function [rk] = rnkCol(cl,nd)
%RNKCOL Rank Collocation points
%	[rk] = rnkCol(cl,nd) gives the rank (percent) of collocation cl based on its distance from mean of data.
%
%	See also rnkMC, chkCs.

%%

%
pD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
load([pD 'polynomial.mat'])

mxvc = max(abs(MC_Vector_SG),[],2)*ones(1,length(MC_Vector_SG));
nrvc = MC_Vector_SG./mxvc;
nrcl = cl./mxvc(:,1);

c = dsearchn(nrvc',nrcl');
[srt rnk] = rnkMC(nd);
rk = find(rnk==c)/length(MC_Vector_SG)*100;

end

