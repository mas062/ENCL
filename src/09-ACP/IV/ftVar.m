function [] = ftVar(nd,ns)
%FtVAR Ftgradation Variables
%   FtVar generates the Ftgradation variable distributions and saves them in
%   directory DST in DATA
% 
%   See also inVar, brVar, ftVar, bwVar.
%
%% Fault Transmissibility Multiplier

dn=1/ns;
x  = [0:dn:1];
n  = numel(x);

pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
if ~exist(pN,'dir'), system(['mkdir ' pN]);end

%
%%%%%%%%%%%%%%%%

%% Ftgradation
% 

% 
	mnFts = 0;
	mxFts = 1;
	scFts = 1;
	%
	colFtsR1 = 0.9;
	colFtsR2 = 0.5;
	colFtsR3 = 0.1;
	tolFts   = 0.05; 
	conFts   = false;
	%
	muFts = 0.5;
	sgFts = 0.0001;
	sgFtse = 1000;
	sgFtStp= 0.001;
	%
	Ft = [];bg=[];cg=[];
	while ~conFts,
		Fts = mnFts + scFts*normrnd(muFts,sgFts,1,length(x));
%		Fts = mnFts + scFts*rand(1,length(x));		
		%
		Fts(Fts>mxFts) = [];
		Fts(Fts<mnFts) = [];
		%
		nFts = numel(Fts);
		nap  = n - nFts 
		if nap>0,
			apFts = rand(1,nap);
			Fts = [Fts apFts];
		end
		%
		sgFts = sgFts + sgFtStp	
		% Check for collocation points.
		colFtsPth = [pN 'colFts.mat'];
		Root = aPoly_Construction(Fts,2,colFtsPth);
		%load(colFtsPth);
		% Check roots
		erFts1 = abs(Root(1)-colFtsR1);
		erFts2 = abs(Root(2)-colFtsR2);
		erFts3 = abs(Root(3)-colFtsR3);
		conFt1 = ~(erFts1>tolFts);
		conFt2 = ~(erFts2>tolFts);
		conFt3 = ~(erFts3>tolFts);
		conFts = (conFt1*conFt2*conFt3);
%		hold on
%		pause(0.0);
%		plot(erFts1,'b');plot(erFts2,'g');plot(erFts3,'r');
		display(['error is ' num2str(erFts1) ' ' num2str(erFts2) ' ' num2str(erFts3)]);
		if sgFts> sgFtse,
%			clf;hold on;
%			plot(Ft,'b'); 
%			plot(bg,'g');
%			plot(cg,'r');
			display('Convergence problem!');
			error('The BSHT did not converge, try settings Ftain');
		end
		Ft(end+1)=erFts1;
		bg(end+1)=erFts2;
		cg(end+1)=erFts3;
	end
	
	FtsPth =[pN '/Fts_' num2str(nd) '.mat'];
	save(FtsPth, 'Fts');
%
figure();
hist(Fts,round(ns/100));
end

