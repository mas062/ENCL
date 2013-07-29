function [] = sobSA(prop,nd)
%SOBSA Sobol Sensistivity Analysis
%   sobSA(prop,nd) performs sensitivity analysis by the means of Sobol indieses
%
%   See also polyGen, polyTune.

propTune = ['/Home/siv16/mas062/prjII/aPC/DATA/' ...
    num2str(nd) '/' prop '_tuneNomial.mat'];

if ~exist(propTune),
	polyTune(prop,nd);
end

load(propTune);


totSob=zeros(N,length(tc));
for t=1:length(tc),
	Coef_1 = C_Output(:,t);
	%Sobol Indices: Computationnal of Location and Var
	for j=2:1:P;
		 location=find(PolynomialDegree(j,:)~=0);
		 LocationInfo(j,location)=location;    
		 TermsVar(j)=sum(Coef_1(j).^2)/sum(Coef_1(2:P).^2);
	end

	%Sobol Indices: Initialization and Definitaion of Dublicates
	for j=2:1:P,    
		 TempSobol(j)=TermsVar(j); %Initialization
		 for i=j:1:P,
		     %Dublicates
		     if ((LocationInfo(j,:)==LocationInfo(i,:)) & (j~=i)),
		         TempSobol(j)=TermsVar(j)+TermsVar(i);            
		         DublicatesIndex(j)=i;
		     end        
		 end
	end    

	%Sobol Indices: Final defenition of Indices
	i=0;
	for j=2:1:P;
		if  j~=DublicatesIndex
		    i=i+1;
		    Sobol(i)=TempSobol(j);
		    SobolInfo(i,:)=LocationInfo(j,:);
		end    
	SobolInices(i,1)=Sobol(i);
	SobolInices(i,2:N+1)=SobolInfo(i,:);
	end
	%sort changed to sorted by meisam
	[sorted index]=sort(Sobol);
	%Sorted Indecis: all in one
	SortSobolInices=SobolInices(index(length(index):-1:1),:); 
	%Total Sobol Indices
	for ii=1:1:N;
		 location=find(PolynomialDegree(:,ii)~=0);
		 SobolTotal(ii)=sum(Coef_1(location).^2)/sum(Coef_1(2:length(Coef_1)).^2);
	end
	totSob(:,t)=SobolTotal;
end

totSobPth = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
totSobFN = ['totSob_' prop];
eval([totSobFN '= totSob;']);
save([totSobPth totSobFN '.mat'],totSobFN);
	%=========================================================================
	%PLOT: Time for <C>max
	hplt=figure();
	LFS=8; %Litle Font Size
	BFS=10; %Big Font Size
	hold on;

	plot(tc,totSob(1,:),tc,totSob(2,:),tc,totSob(3,:),tc,totSob(4,:),'LineWidth',3);
	lg=legend('barrier','aggradation','fault trans.','boundary condition');
%	title([propTtl(prop)],'FontWeight', 'bold');
	set(gca,'Color',[1 1 1],'FontSize',20);
	set(lg,'FontSize',13);
	set(gcf,'Color',[1 1 1]);
%	set(gcf,'LineWidth',6); 
	set(gcf,'Position',[400 200 350 300]);
	box on;

figPth = ['~/prjII/aPC/PICs/SA_Pics/'];
figName = ['sbPlot_' num2str(nd) '_'];
figure(hplt);
%h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Total Sobol Indices');
savePltFig(hplt,figName,figPth,prop);


	%=========================================================================

	fprintf(['Sobol Indices for << ' prop ' >> are calculated. \n']);
	fprintf('==========================================================\n');
	end
