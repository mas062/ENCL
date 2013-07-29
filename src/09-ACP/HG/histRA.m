function [] = histRA(prop,nd,clr)
%histRA Risk Analysis
%	histRA(prop,nd) takes the property prop and performs the risk
%  analysis related to the property.
% 	
%	See also, sobSA, polyTune, polyGen.
%
%%

%%
nds = num2str(nd);
acpPth = ['C:\Users\meisama\Documents\PhD\aPC\' nds '\'];
propTune = [acpPth prop '_tuneNomial.mat'];
load(propTune);
%%
h1=figure(1);
clf(h1);
%
ti = max(find(tc<=30))
te = length(tc)
vctI = PCMMC_Output(:,ti);
vctS = PCMMC_Output(:,te);
%
vctI(vctI<0) = [];
vctS(vctS<0) = [];
%
figName = 'hst';
% figPth = '/runs/DATA/BKUP/REPORT/ACP/paper/PICs/RA_Pics/';
figPth = 'C:\Users\meisama\Documents\PhD\aPC\PICs\RA_Pics\';%
hist(vctI,100);
%
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor',clr,'EdgeColor','w');
set(gca,'FontSize',20);

pt = propTtl(prop);
pu = propUnit(prop);
% ttl = ['Histogram of ' pt ' at End of Injection'];
xtext = [pt ', ' pu];
ytext = 'Number of cases';
%title(ttl,'FontSize',15);
xlabel(xtext,'FontSize',20);
ylabel(ytext,'FontSize',20);
%
fNm = [figPth figName 'I_' prop '_' clr];
saveas(h1,fNm,'epsc');
saveas(h1,fNm,'fig');
system(['epstopdf ' fNm '.eps']);

%%
h2=figure(2);
clf(h2);
%
hist(vctS,100);
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor',clr,'EdgeColor','w');
set(gca,'FontSize',20);
%
pt = propTtl(prop);
pu = propUnit(prop);
% ttl = ['Histogram of ' pt ' at End of Simulation'];
xtext = [pt ', ' pu];
ytext = 'Number of cases';
% title(ttl,'FontSize',15);
xlabel(xtext,'FontSize',20);
ylabel(ytext,'FontSize',20);
set(gca,'FontSize',20);
%
fNm = [figPth figName 'S_' prop '_' clr];
saveas(h2,fNm,'epsc');
saveas(h2,fNm,'fig');
system(['epstopdf ' fNm '.eps']);
%
end
