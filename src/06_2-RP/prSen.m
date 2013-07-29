function [] = prSen(scn,prop)
%PRSEN Pressure Sensitivity
%   prSen(scn,prop) plots the tornado chart for property prop related to
%   scenario scn.
%
%   See also bsGrad.

%%
GP = [];
for bs = 1:5,
    gP = bsPrGrad(scn,prop,bs);
    GP(end+1) = gP;
end
nGP = GP/max(abs(GP));
h = figure;
barh(nGP);
title([propTtl(prop) ' (' propUnit(prop) ') ' scn]);
grid on;
%
prsFig = '/scratch/projects/SAIGUPRS/pics/';
saveas(h,[prsFig 'sen_' prop],'fig');
saveas(h,[prsFig 'sen_' prop],'epsc');
end

