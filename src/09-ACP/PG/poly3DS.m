function [] = polyTune3DS()
%POLYTUNE Poly Tune
%   polyTune(prop) tunes the polynomial generated based on the input variables.
% 
%   See also polyGen, rspVct, clcAcpPlt.

%%

%% Load data
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/'];
pNP = [pN 'PCMM_S/'];


%Load workspace variables
polyFile = [pN 'polynomial.mat'];
load(polyFile);

% Load detailed run results and corresponding collocation values.
[vc,tc,cl] = rspVct3DS();
vcfile = [pN 'vc3DS.mat'];
save(vcfile,'-v7.3','vc','tc','cl');
%load(vcfile,'vc','tc','cl');
tscl = 365;
cellnum =78720; 
%---------- P. C. M.: Matrix Solver ZC(T)=Y(T)   
inv_Z=pinv(Z);

%

polyFile = [pN 'polyCo.mat'];
load(polyFile,'C_Output');



 
%Polinomial MC+PCM Computation
MCsize=size(MC_Vector_SG);
MCsize=MCsize(2);
 
% 
basisFile = [pN 'MC_Poly.mat'];
load(basisFile,'MC_Poly');


for l=1:MCsize,
	for i=1:1:cellnum 
		PCMMC_Output(l,i)=0;
		for j=1:1:P;
			multi=1;
			for ii=1:1:N;          
				multi=multi*MC_Poly(ii,j,l);
			end             
			PCMMC_Output(i)=PCMMC_Output(i)+C_Output(j,i)*multi;
		end
		display([num2str(l/MCsize) '%']);
	end  
	%Computational Time
	fprintf('---> M.C. on Polynomial: ');
	disp([datestr(now) ' - ' num2str(round(100*i/(cellnum-1))) '% completed']);
	PCMMCfile = [pNP 'PCMMC_Sat_' kpdg(l,5) '.mat'];
	save(PCMMCfile,'-v7.3','PCMMC_Output');
end
 

 %
 LFS=9; %Litle Font Size
 BFS=10; %Big Font Size     
 % Plotting informations
 xtxt = 'Time (years)';
 ytxt = 'Water Saturation';
 
 figure()
 %--------------- Mean Values Computation and Plot
 collor = 0.7;
 for i=1:1000:cellnum
     %PCM_MeanCO2Leakage(i)=C_CO2Leakage(1,i);   
     PCM_MeanOutput(i)=mean(PCMMC_Output(:,i));
 end
 hold on;
 line2=plot(tc/(tscl),PCM_MeanOutput,'-');
 set(line2, 'Color', [0. 0. 0.]+collor, 'LineWidth', 2);     
 
 

 grid on;
 set(gca,'FontSize',BFS)
 set(gca,'FontSize',LFS)
 xlabel(xtxt);
 ylabel(ytxt);
 title(['Mean Value of ' ytxt],'FontWeight', 'bold');
 set(gca,'Color',[1 1 1])
 set(gcf,'Color',[1 1 1]);
 set(gcf,'Position',[100 200 400 350]);
 
 
 legend('Data-driven','Expert 1', 'Expert 2', 'Expert 3', 'Expert 4', 'Expert 5');
 
 %toc
 fprintf('______________________________________________________________________________________________________________\n');
 fprintf('______________________________________________________________________________________________________________\n');
 
 
end
