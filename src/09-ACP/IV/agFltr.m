function [] = agFltr(nd,ns)
%AGVAR Aggradation Variables
%   agVar(nd,ns) generates the aggradation variable distributions and saves them in
%   directory DST in DATA
%
%   See also inVar, brVar, ftVar, bwVar.
%
%% Fault Transmissibility Multiplier
dn = 1/ns;
x  = 0:dn:1;
n  = numel(x);
%
%%%%%%%%%%%%%%%%
pN = ['C:\Users\meisama\Documents\PhD\aPC\' num2str(nd) '\'];
if ~exist(pN,'dir'), system(['mkdir ' pN]);end

%% Aggradation
%

%
mnAgr = 0;mxAgr = 1;scAgr = 1;muAgr = 0.5;sgAgr = 0.08;
Agr = mnAgr + scAgr*normrnd(muAgr,sgAgr,1,length(x));
%		Agr = mnAgr + scAgr*rand(1,length(x));
%
Agr(Agr>mxAgr) = [];
Agr(Agr<mnAgr) = [];
%
nAgr = numel(Agr);
nap  = n - nAgr
if nap>0,
    apAgr = rand(1,nap);
    Agr = [Agr apAgr];
end
%
agrPth =[pN 'fltrAgr_' num2str(nd) '.mat'];
save(agrPth, 'Agr');
%
figure();
hist(Agr,round(ns/100));
end

