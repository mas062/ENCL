function [] = prSenAll(scn)
%PRSENALL Pressure Sensitivity All Responses
%   prSen(scn) plots the tornado chart for all pressure responses related to
%   scenario scn.
%
%   See also bsGrad.

%%
prop = {'FPR2','pv','dpv','disdp','WRPD','tinc'};
for i=1:length(prop),
	prSen(scn,char(prop(i)));
end

end

