function [] = polyTune3D()
%POLYTUNE Poly Tune
%   polyTune(prop) tunes the polynomial generated based on the input variables.
% 
%   See also polyGen, rspVct, clcAcpPlt.

%%

%% Load data
pN = [enclDir 'ACP/'];

%Load workspace variables
polyFile = [pN 'polynomial.mat'];
load(polyFile);

% Load detailed run results and corresponding collocation values.
[vc,tc,cl] = rspVct3DP();
vcfile = [pN 'vc3DP.mat'];
save(vcfile,'-v7.3','vc','tc','cl');
%load(vcfile,'vc','tc','cl');
tscl = 365;
cellnum =78720; 
%---------- P. C. M.: Matrix Solver ZC(T)=Y(T)   
inv_Z=pinv(Z);

%
cnt=0;
tfr = 4;

for t = 1:tfr:size(tc),
	for c=1:cellnum,
		temp = [];	
		for ii=1:1:P,
			  temp(end+1)=vc{ii}{t}(c);
		end
		C_Output(:,c) = inv_Z*temp';
		cnt=cnt+1;
		rto = cnt/(cellnum*numel(1:tfr:size(tc)))*100;
%		waitbar(rto,'Calculating Polynomial Coefficients')
		clc
		display(['Polynomial Coeff. ' num2str(rto) ' %'])                   
%		fprintf(1,'\b%d',rto);
	end
	polyTFile = [pN 'polyTCo' kpdg(t,3) '.mat'];
	save(polyTFile,'-v7.3','C_Output');
	display(['saved for timestep ' num2str(t)]);	
end
fprintf('\n')    
polyFile = [pN 'polyCo.mat'];
save(polyFile,'-v7.3','C_Output');



%
% % % fprintf('\n');
% % % fprintf('______________________________________________________________________________________________________________\n');
 
 %Polinomial MC+PCM Computation
MCsize=size(MC_Vector_SG);
MCsize=MCsize(2);
 
 %Pre Computation for d and N
for j=1:1:P;
    for ii=1:1:N;     
        load(PolynomialBasisFileName{ii},'Polynomial');
        MC_Poly(ii,j,:)=polyval(Polynomial(1+PolynomialDegree(j,ii),length(Polynomial):-1:1),MC_Vector_SG(ii,:));
    end
end
% 
basisFile = [pN 'MC_Poly.mat'];
save(basisFile,'-v7.3','MC_Poly');

% % % for i=4001:4002,%:cellnum 
% % %     for l=1:MCsize;
% % %        PCMMC_Output(l,i)=0;
% % %        for j=1:1:P;
% % %             multi=1;
% % %             for ii=1:1:N;          
% % %                 multi=multi*MC_Poly(ii,j,l);
% % %             end             
% % %             PCMMC_Output(l,i)=PCMMC_Output(l,i)+C_Output(j,i)*multi;
% % %        end
% % %        display([num2str(l/MCsize) '%']);
% % %     end  
% % %      
% % %    %Computational Time
% % %    fprintf('---> M.C. on Polynomial: ');
% % %    disp([datestr(now) ' - ' num2str(round(100*i/(cellnum-1))) '% completed']);
% % % end
% % % 
% % % %CO2 Leakage Check Out of Pysical Boards
% % % %for i=1:1000:cellnum 
% % % %    for l=1:MCsize;
% % % %        if PCMMC_Output(l,i)<0;
% % % %            PCMMC_Output(l,i)=0;
% % % %        end
% % % %    end
% % % %end 
% % % tuneFile = [pN 'SWAT_tuneNomial.mat'];
% % % PCMMCfile = [pN 'PCMMC_SWnomial.mat'];
% % % save(PCMMCfile,'-v7.3','PCMMC_Output');
% % % clear PCMMC_Output
% % % save(tuneFile,'-v7.3');
% % % load PCMMCfile
% % % %
% % % LFS=9; %Litle Font Size
% % % BFS=10; %Big Font Size     
% % % % Plotting informations
% % % xtxt = 'Time (years)';
% % % ytxt = 'Water Saturation';
% % % 
% % % figure()
% % % %--------------- Mean Values Computation and Plot
% % % collor = 0.7;
% % % for i=1:1000:cellnum
% % %     %PCM_MeanCO2Leakage(i)=C_CO2Leakage(1,i);   
% % %     PCM_MeanOutput(i)=mean(PCMMC_Output(:,i));
% % % end
% % % hold on;
% % % line2=plot(tc/(tscl),PCM_MeanOutput,'-');
% % % set(line2, 'Color', [0. 0. 0.]+collor, 'LineWidth', 2);     
% % % 
% % % 
% % % %area(TimeVector/(60*60*24),PCM_MeanCO2Leakage,'b');
% % % %colormap([.1 .5 1.]);
% % % %colormap([1 1 1]);
% % % %set(gca,'Layer','top')
% % % 
% % % grid on;
% % % set(gca,'FontSize',BFS)
% % % set(gca,'FontSize',LFS)
% % % xlabel(xtxt);
% % % ylabel(ytxt);
% % % title(['Mean Value of ' ytxt],'FontWeight', 'bold');
% % % set(gca,'Color',[1 1 1])
% % % set(gcf,'Color',[1 1 1]);
% % % set(gcf,'Position',[100 200 400 350]);
% % % 
% % % 
% % % legend('Data-driven','Expert 1', 'Expert 2', 'Expert 3', 'Expert 4', 'Expert 5');
% % % 
% % % %toc
% % % fprintf('______________________________________________________________________________________________________________\n');
% % % fprintf('______________________________________________________________________________________________________________\n');
% % % 
% % % 
end
