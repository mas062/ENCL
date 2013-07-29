function [] = apreAcpEcl(nd)
%APREACPECL Apre Run ACP Eclipse Output
%   pareAcpEcl() converts the Eclipse results for ACP runs and calcultaes the plot vectors
% Also it zipps the restarts.
%
%   See also clcAcpPlt, inVar, fndCln.

%% Load Collocation Bases
pN = [enclDir 'ACP/' num2str(nd) '/'];
%Load workspace variables
polyFile = [pN 'polynomial.mat'];
load(polyFile,'CollocationPointsBase');

for i=1:size(CollocationPointsBase,1),
	cs = col2cs(CollocationPointsBase(i,:));
	convEclDyn(cs);
	clcPlt(cs);
	zipRst(cs);
	rmRst(cs);
end

end
