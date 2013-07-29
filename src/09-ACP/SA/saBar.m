function [] = saBar(nd)
%SAPLT Sensistivity Analysis Plots
%   saPlt(nd) plots the total Sobol indices used in the sensitivity analysis.
%
%   See also sobSA.

%%
prp = { 'FPR'...
			'totMobCo2'...
			'totResCo2'...
			'largestPlume'...
			'meanPlume'...
			'WBHP'...
			'plumeNum'...
			'leakageRisk'...
			};
%			
nds=num2str(nd);
sobVi = [];
sobVs = [];
%
totSobPth = ['/Home/siv16/mas062/prjII/aPC/DATA/' nds '/'];
%
for pr=1:length(prp),
	prpTune = ['/Home/siv16/mas062/prjII/aPC/DATA/' ...
        num2str(nd) '/' prp{pr} '_tuneNomial.mat'];
	if ~exist(prpTune),
		polyTune(prp,nd);
	end
	load(prpTune);
	tinj = 30;
	tin_eoi = max(find(tc<=tinj));
	tin_eos = length(tc);
	%
	totSobFN = ['totSob_' prp{pr}];
	comN = [totSobPth totSobFN];
	if false,%~exist(comN),
		sobSA(prp{pr},nd);
	end
	load(comN);
	eval(['sobVi{1+end} = ' totSobFN '(:,' num2str(tin_eoi) ');']);
	eval(['sobVs{1+end} = ' totSobFN '(:,' num2str(tin_eos) ');']);
	close all;
end
%
close all;
%
if true,
	for pr = 1:length(prp),

	%prepare data
	%
	%	prpTune = [enclDir 'ACP/' num2str(nd) '/' prp{pr} '_tuneNomial.mat'];
	%	if ~exist(prpTune),
	%		polyTune(prp,nd);
	%	end
	%	load(prpTune);
	%	%
	%	tinj = 30;
	%	tin_eoi = max(find(tc<=tinj));
	%	tin_eos = length(tc);
		sobV = [sobVi{pr} sobVs{pr}];

	%plot figures
	%
		%
		h=figure;
		hb=bar(sobV,'k','BarWidth',0.7,'EdgeColor','none');
		set(hb(2),'FaceColor',0.65*[1 1 1]);
		%
		dim =['Barr.';'Aggr.';'Fault';'B.C. '];
		set(gca, 'XTickLabel', dim,'FontSize',20,'YLim',[0 1]);
		ylabel('Total Sobol Indices','FontSize',20);
		l=legend('End of injection','End of simulation');
		set(l,'FontSize',15);


	%save figure
	%
		%savepath
		figPth = ['~/prjII/aPC/PICs/SA_Pics/' nds '/'];
		if ~exist(figPth,'dir'),system(['mkdir ' figPth]);end

		%endofinjection
		figName = ['saBar_'];
		figure(h);
		%
		saveas(h,[figPth figName prp{pr} '_' num2str(nd) '.eps'],'epsc');
		saveas(h,[figPth figName prp{pr} '_' num2str(nd) '.fig'],'fig');
	
	end
end
%
end

