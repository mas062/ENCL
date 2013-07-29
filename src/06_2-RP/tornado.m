function [] = tornado(scn,prop)
%TORNADO Tornado Chart
%   tornado(scn,prop) plots the tornado chart for property prop related to
%   scenario scn.
%
%   See also bsGrad.

%%
GI = [];
GS = [];
for bs = 1:5,
    [gI gS] = bsGrad(scn,prop,bs);
    GI(end+1) = gI;
    GS(end+1) = gS;
end

figure;
barh(GI);
title([propTtl(prop) ' (' propUnit(prop) '), End Of Injection, ' scn]);
grid on;
figure;
barh(GS);
title([propTtl(prop) ' (' propUnit(prop) '), End Of Simulation, ' scn]);
grid on;
%
end

