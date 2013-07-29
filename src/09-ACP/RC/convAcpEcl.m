function [] = convAcpEcl(nd)
%CONVACPECL Convert ACP Eclipse Output
%   convAcpEcl() converts the Eclipse results for ACP runs
%
%   See also clcAcpPlt, inVar, fndCln.

%% Load Collocation Bases
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
%Load workspace variables
polyFile = [pN 'polynomial.mat'];
load(polyFile,'CollocationPointsBase');

for i=1:size(CollocationPointsBase,1),
	cs = col2cs(CollocationPointsBase(i,:),nd);
	if runOk(cs),
		convEclDyn(cs);
		zipRst(cs);
		rmRst(cs);
	end
end

end
