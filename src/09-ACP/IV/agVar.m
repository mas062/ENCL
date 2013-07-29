function [] = agVar(nd,ns)
%AGVAR Aggradation Variables
%   agVar(nd,ns) generates the aggradation variable distributions and saves them in
%   directory DST in DATA
% 
%   See also inVar, brVar, ftVar, bwVar.
%
%% Fault Transmissibility Multiplier
dn = 1/ns;
x  = [0:dn:1];
n  = numel(x);
%
%%%%%%%%%%%%%%%%
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
if ~exist(pN,'dir'), system(['mkdir ' pN]);end

%% Aggradation
% 

% 
	mnAgr = 0;
	mxAgr = 1;
	scAgr = 1;
	%
	colAgrR1 = 0.9;
	colAgrR2 = 0.5;
	colAgrR3 = 0.1;
	tolAgr   = 0.05; 
	conAgr   = false;
	%
	muAgr = 0.5;
	sgAgr = 0.0001;
	sgAgre = 100000000;
	sgAgStp= 0.001;
	%
	ag = [];bg=[];cg=[];
	while ~conAgr,
		Agr = mnAgr + scAgr*normrnd(muAgr,sgAgr,1,length(x));
%		Agr = mnAgr + scAgr*rand(1,length(x));		
		%
		Agr(Agr>mxAgr) = [];
		Agr(Agr<mnAgr) = [];
		%
		nAgr = numel(Agr);
		nap  = n - nAgr 
		if nap>0,
			apAgr = rand(1,nap);
			Agr = [Agr apAgr];
		end
		%
		sgAgr = sgAgr + sgAgStp;	
		% Check for collocation points.
		colAgrPth = [pN 'colAgr.mat'];
		Root = aPoly_Construction(Agr,2,colAgrPth);
		%load(colAgrPth);
		% Check roots
		erAgR1 = abs(Root(1)-colAgrR1);
		erAgR2 = abs(Root(2)-colAgrR2);
		erAgR3 = abs(Root(3)-colAgrR3);
		conAg1 = ~(erAgR1>tolAgr);
		conAg2 = ~(erAgR2>tolAgr);
		conAg3 = ~(erAgR3>tolAgr);
		conAgr = (conAg1*conAg2*conAg3);
		hold on
%		pause(0.0);
%		plot(erAgR1,'b');plot(erAgR2,'g');plot(erAgR3,'r');
		display(['error is ' num2str(erAgR1) ' ' num2str(erAgR2) ' ' num2str(erAgR3)]);
		if sgAgr> sgAgre,
%			clf;hold on;
%			plot(ag,'b'); 
%			plot(bg,'g');
%			plot(cg,'r');
			display('Convergence problem!');
			error('The BSHT did not converge, try settings again');
		end
		ag(end+1)=erAgR1;
		bg(end+1)=erAgR2;
		cg(end+1)=erAgR3;
	end
	
	agrPth =[pN '/Agr_' num2str(nd) '.mat'];
	save(agrPth, 'Agr');
%
figure();
hist(Agr,round(ns/100));
end

