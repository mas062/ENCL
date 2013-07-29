function [] = cdfRA(prop,nd)
%CDFRA Cummulative Distribution Function Risk Analysis
%	cdfRA(prop,nd) takes the property prop and plots the cdf of risk
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

h = figure(1); % Numerical Computation CO2 Leakae CDF
clf;
%
MCV = [];
rmi = [];
%
for i=1:1:length(tc),
    vc = PCMMC_Output(:,i);
    rmi = unique([rmi find(vc<0)']);
    outVc(i,:) = vc;
end
    rmi = unique(sort(rmi));
    
    MC_Vector_SG(:,rmi)=[];
    MCsize = length(MC_Vector_SG());
    for k = 1:1:MCsize;
        num_CDF(k)=(k-1)/(MCsize)+1/(2*MCsize);
    end
%     for t=1:length(tc),
        outVc(:,rmi)=[];
        sortvc = sort(outVc,2);
%     end

surf(tc,num_CDF,sortvc(:,:)');
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
LFS=15; %Litle Font Size
BFS=20; %Big Font Size     set(gca,'FontSize',BFS)
%title(propTtl(prop),'FontSize', BFS);
set(gca,'FontSize',LFS)
xlabel('Time, years','FontSize',BFS);
ylabel('Probability','FontSize',BFS);
zlabel([propTtl(prop) ', ' propUnit(prop)],'FontSize',BFS);
set(gca,'Color',[1 1 1])
set(gcf,'Color',[1 1 1]);
set(gcf,'Position',[100 200 500 350]);
%zlim([0 0.3]);
%caxis([0 0.3]);
figName = 'cdf';
% figPth = '/runs/DATA/BKUP/REPORT/ACP/paper/PICs/RA_Pics/';
figPth = 'C:\Users\meisama\Documents\PhD\aPC\PICs\RA_Pics\';
fNm = [figPth figName '_' prop];
saveas(h,fNm,'epsc');
saveas(h,fNm,'fig');
system(['epstopdf ' fNm '.eps']);
end


