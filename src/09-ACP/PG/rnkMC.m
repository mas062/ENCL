function [srt rnk] = rnkMC(nd)
%RNKMC Rank Monte-Carlo vector
%	[srt rnk] = rnkMC(nd) sorts input MC vector based on their distance from mean of data.
%
%	See also chkCs.

%%

%
pD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
load([pD 'polynomial.mat'])

avvc = mean(MC_Vector_SG,2)*ones(1,length(MC_Vector_SG));
mxvc = max(abs(MC_Vector_SG),[],2)*ones(1,length(MC_Vector_SG));
scvc = mxvc-avvc;
mtvc = abs(MC_Vector_SG-avvc)./scvc;
metric = mean(mtvc,1);

[srt rnk] = sort(mtvc,2);

end

