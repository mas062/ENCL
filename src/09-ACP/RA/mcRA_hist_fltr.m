function [] = mcRA_hist(prop,nd)
%MCRA Monte Carlo Risk Analysis
%	mcRA(prop) takes the property prop and performs the risk
%  analysis related to the property.
% 	
%	See also, sobSA, saBar, polyTune, polyGen.
%
%%

%%
tic
acpPth = ['C:\Users\meisama\Documents\PhD\aPC\' nd '\'];
propTune = [acpPth prop '_tuneNomial.mat']
if ~exist(propTune),
	polyTune(prop,nd);
end
%
load(propTune);
%

mcFile = [acpPth prop '_MC.mat'];
if ~exist(mcFile,'file');
    polyMC(prop,nd);
end
load(mcFile);

%
%figure(1) % Numerical Computation CO2 Leakae CDF
for k = 1:1:MCsize,
   num_PCMMC_CDF(k)=(k-1)/(MCsize)+1/(2*MCsize);
end
%
for i=1:1:length(tc),
    sortPCMMC(:,i)=sort(PCMMC_fltr(:,i));
end
%
T = tc;
A = num_PCMMC_CDF;
B = sortPCMMC(:,:);
cdfN =[acpPth prop '_CDF_fltr.mat']; 
save(cdfN, 'T','A','B');
%cmd = ['rsync -avz ' cdfN ' mas062@129.177.32.11:/media/bk/SAIGUP/DATA/ACP/' ];
%system(cmd);
%%% surf(tc,num_PCMMC_CDF,sortPCMMC(:,:));
%%% shading interp;
%
%%% hold on;


%%% camproj perspective;
%%% camlight(-45,10);
%%% camlight(-45,-160);
%%% lighting phong;
%%% colormap jet;
%%% colorbar;
%%% view(-45,25);
%%% grid on;
%%% LFS=9; %Litle Font Size
%%% BFS=10; %Big Font Size     set(gca,'FontSize',BFS)
%%% title('CDF of CO_2 Leakage','FontWeight', 'bold');
%%% set(gca,'FontSize',LFS)
%%% xlabel('Time, [days]');
%%% ylabel('Probability');
%%% zlabel('CO_2 Leakage, [%]');
%%% set(gca,'Color',[1 1 1])
%%% set(gcf,'Color',[1 1 1]);
%%% set(gcf,'Position',[100 200 500 350]);
%%% zlim([0 0.3]);
%%% caxis([0 0.3]);
%%% 
%%% 
toc
%
end
