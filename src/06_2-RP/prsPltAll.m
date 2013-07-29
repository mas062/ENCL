function [] = prPltAll(scn)
%PRSENALL Pressure Plot All Responses
%   prPltAll(scn) plots all pressure responses related to
%   scenario scn.
%
%   See also bsGrad.

%%
prop = {'FPR2','pv','dpv','disdp','WRPD','tinc'};
lg = [0 1 1 0 0 0];
for i=1:length(prop),
	pltAll(scn,char(prop(i)),lg(i));
end

end

