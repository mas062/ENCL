function [] = aveRA_fltr(prop,nd)
%aveRA Average Value Risk Analysis
%	aveRA(prop) takes the property prop and calculates the average 
% 	value for response
%	See also, sobSA, polyTune, polyGen.
%
%%
nds = num2str(nd);
%%
acpPth = ['C:\Users\meisama\Documents\PhD\aPC\' nds '\'];
propTune = [acpPth prop '_tuneNomial.mat'];
if exist(propTune,'file'),load(propTune);else display('Careful, no tune file exist!');end
mcFile = [acpPth prop '_MC.mat'];
if ~exist(mcFile,'file');
    polyMC(prop,nd);
end
load(mcFile);

%%
figName = 'aveFltr';
% figPth = '/runs/DATA/BKUP/REPORT/ACP/paper/PICs/RA_Pics/';
figPth = 'C:\Users\meisama\Documents\PhD\aPC\PICs\RA_Pics\';
h1=figure(1);
clf(h1);
%
ti = max(find(tc<=30))
te = length(tc)
vctI = PCMMC_fltr(:,ti);
vctS = PCMMC_fltr(:,te);
%
vctI(vctI<0) = [];
vctS(vctS<0) = [];
%
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
% 
% LFS=9; %Litle Font Size
% BFS=10; %Big Font Size     
% Plotting informations
xtxt = 'Time (years)';
ytxt = propTtl(prop);
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%%
pt = propTtl(prop);
pu = propUnit(prop);
ttl = ['Average ' pt];
PCM_MeanOutput=[];
for i=1:1:length(tc), 
    PCM_MeanOutput(end+1)=mean(PCMMC_fltr(:,i));
end
plot(tc,PCM_MeanOutput,'-','LineWidth',3,'Color','k');
%title(ttl,'FontSize',15);
xlabel(xtxt,'FontSize',20);
ylabel(ytxt,'FontSize',20);
set(gca,'FontSize',20);
fNm = [figPth figName '_' prop];
saveas(h1,fNm,'epsc');
saveas(h1,fNm,'fig');
system(['epstopdf ' fNm '.eps']);
%
end
