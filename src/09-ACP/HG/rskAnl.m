function [] = rskAnl(prop)
%RSKANL Risk Analysis
%	rskAnl(prop) takes the property prop and performs the risk
%  analysis related to the property.
% 	
%	See also, sobSA, polyTune, polyGen.
%
%%

%%
tic

propTune = ['./' prop '_tuneNomial.mat']
load(propTune);

figure(1) % Numerical Computation CO2 Leakae CDF
for k = 1:1:MCsize;
   num_PCMMC_CDF(k)=(k-1)/(MCsize)+1/(2*MCsize);
end
for i=1:1:length(tc),
    sortPCMMC(:,i)=sort(PCMMC_Output(:,i));
end

surf(tc/(60*60*24),num_PCMMC_CDF,sortPCMMC(:,:));
shading interp;
hold on;


camproj perspective;
camlight(-45,10);
camlight(-45,-160);
lighting phong;
colormap jet;
colorbar;
view(-45,25);
grid on;
LFS=9; %Litle Font Size
BFS=10; %Big Font Size     set(gca,'FontSize',BFS)
title('CDF of CO_2 Leakage','FontWeight', 'bold');
set(gca,'FontSize',LFS)
xlabel('Time, [days]');
ylabel('Probability');
zlabel('CO_2 Leakage, [%]');
set(gca,'Color',[1 1 1])
set(gcf,'Color',[1 1 1]);
set(gcf,'Position',[100 200 500 350]);
zlim([0 0.3]);
caxis([0 0.3]);


toc
fprintf('========================================================================\n');
fprintf('========================================================================\n');
