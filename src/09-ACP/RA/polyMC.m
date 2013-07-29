function [] = polyMC(prop,nd)
%POLYMC Poly MC Vector
%   polyMc(prop,nd) produces MC array based on the polynomial generated 
%   based on the input variables for property prop and run series nd.
% 
%   See also polyGen, rspVct, clcAcpPlt.

%%

%% Load data
pN = ['C:\Users\meisama\Documents\PhD\aPC\' num2str(nd) '\'];
propTune = [pN prop '_tuneNomial.mat'];
load(propTune);
pN = ['C:\Users\meisama\Documents\PhD\aPC\' num2str(nd) '\'];
%---------- P. C. M.: Matrix Solver ZC(T)=Y(T)   
%Polinomial MC+PCM Computation

vN1 = [pN 'Brr_' num2str(nd) '.mat'];
%vN2 = [pN 'Agr_' num2str(nd) '.mat'];
vN2 = [pN 'fltrAgr_' num2str(nd) '.mat'];%FILTERED AGR
vN3 = [pN 'Fts_' num2str(nd) '.mat'];
vN4 = [pN 'Bkw_' num2str(nd) '.mat'];
%
%load(vN,'varName');
load(vN1,'Brr');
load(vN2,'Agr');
load(vN3,'Fts');
load(vN4,'Bkw');
%
%%
MC_Vector_SG = [Brr;Agr;Fts;Bkw];


MCsize=size(MC_Vector_SG);
MCsize=MCsize(2);

%Pre Computation for d and N
for j=1:1:P;
    for ii=1:1:N;     
        load([pN 'PolynomialBasis\PolynomialBasis_' num2str(ii) '.mat'],'Polynomial');
        MC_Poly(ii,j,:)=polyval(Polynomial(1+PolynomialDegree(j,ii),length(Polynomial):-1:1),MC_Vector_SG(ii,:));
    end
end

for i=1:1:length(tc) 
    for l=1:MCsize;
       PCMMC_Output(l,i)=0;
       for j=1:1:P;
            multi=1;
            for ii=1:1:N;          
                multi=multi*MC_Poly(ii,j,l);
            end             
            PCMMC_Output(l,i)=PCMMC_Output(l,i)+C_Output(j,i)*multi;
       end
    end  
     
   %Computational Time
   fprintf('---> M.C. on Polynomial: ');
   disp([datestr(now) ' - ' num2str(round(100*i/(length(tc)-1))) '% completed']);
end

%CO2 Leakage Check Out of Pysical Boards
for i=1:1:length(tc) 
    for l=1:MCsize;
        if PCMMC_Output(l,i)<0;
%           PCMMC_Output(l,i)=0;
        end
    end
end 
clear 'cs';
PCMMC_fltr=PCMMC_Output;
mcFile = [pN prop '_MC.mat'];
save(mcFile,'PCMMC_fltr');
end

