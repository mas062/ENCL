function [] = polyTune(prop)
%POLYTUNE Poly Tune
%   polyTune(prop) tunes the polynomial generated based on the input variables.
% 
%   See also polyGen, rspVct, clcAcpPlt.

%%

%% Load data
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/'];

%Load workspace variables
polyFile = [pN 'polynomial.mat'];
load(polyFile);

% Time settings
cs = col2cs(CollocationPointsBase(1,:));
pthRst = [pthVCT(cs) cs '_RST.mat'];
pthSmry = [pthVCT(cs) cs '_SMRY.mat'];
load(pthRst);
load(pthSmry);
[smryEOI,rstEOI] = eOI(smry,rst);

% Load detailed run results and corresponding collocation values.
[vc,tc,cl] = rspVct(prop);
%[rsI,cl] = rspVct('rstTI');
%TimeStep = [];
isSmry = (prop(1)=='F')+(prop(1)=='W');

%
if isSmry, 
    tstp = 'smryT';
    tscl = 1;
    eoi = smryEOI;
else 
    tstp = 'rstT';
    tscl = 365;
    eoi = rstEOI;
end

% Dividing time
%vci = cellfun(@x x(1:eoi),vc,'UniformOutput', false);

%vce = cellfun(@x x(eoi+1:end),vc,'UniformOutput', false);


%for i=1:P,
%	cs = col2cs(CollocationPointsBase(i,:));
%	pltN = [pthVCT(cs) cs '_PLT.mat'];
%	load(pltN,tstp);
%	TStep = eval(tstp);
%	if ~isSmry, 
%		TimeStep{end+1} = TStep(rsI{1}+1);
%	else
%		TimeStep{end+1} = TStep;
%	end
%	%clear(tstp);
%	%clear tstp;
%end
%


%
% Check if the stored vectors correspond to the same number of collocation
% points in the study
if P~= length(vc),
    error('Number of runs does not correspond to the loaded run results!');
end

%---------- P. C. M.: Matrix Solver ZC(T)=Y(T)   

inv_Z=pinv(Z);
%for j=1:1:eoi,

for j=eoi+1:length(tc),
temp = [];
	for ii=1:1:P,
        temp(end+1)=vc{ii}(j);
   end
   C_Output(:,j) = inv_Z*temp';                        
end

fprintf('\n');
fprintf('______________________________________________________________________________________________________________\n');

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

for i=eoi+1:1:length(tc), 
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
            PCMMC_Output(l,i)=0;
        end
    end
end 
tuneFile = [pN prop '_tuneNomial.mat'];
save(tuneFile);

%
LFS=9; %Litle Font Size
BFS=10; %Big Font Size     
% Plotting informations
xtxt = 'Time (years)';
ytxt = propTtl(prop);

figure()
%--------------- Mean Values Computation and Plot
collor = 0.7;
for i=1:1:length(tc) 
    %PCM_MeanCO2Leakage(i)=C_CO2Leakage(1,i);   
    PCM_MeanOutput(i)=mean(PCMMC_Output(:,i));
end
hold on;
line2=plot(tc/(tscl),PCM_MeanOutput,'-');
set(line2, 'Color', [0. 0. 0.]+collor, 'LineWidth', 2);     


%area(TimeVector/(60*60*24),PCM_MeanCO2Leakage,'b');
%colormap([.1 .5 1.]);
%colormap([1 1 1]);
%set(gca,'Layer','top')

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

