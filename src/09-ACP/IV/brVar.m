function [] = brVar(nd,ns)
%BrVAR Brgradation Variables
%   BrVar(nd,ns) generates the Brgradation variable distributions and saves them in
%   directory DST in DATA
% 
%   See also inVar, brVar, ftVar, bwVar.
%
%% 
dn = 1/ns;
x  = [0:dn:1];
n  = numel(x);

pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
if ~exist(pN,'dir'), system(['mkdir ' pN]);end

%
%%%%%%%%%%%%%%%%

%% Brgradation
% 

% 
	mnBrr = 0;
	mxBrr = 1;
	scBrr = 1;
	%
	colBrrR1 = 0.9;
	colBrrR2 = 0.5;
	colBrrR3 = 0.1;
	tolBrr   = 0.05; 
	conBrr   = false;
	%
	muBrr = 0.5;
	sgBrr = 0.0001;
	sgBrre = 10;
	sgBrStp= 0.001;
	%
	Br = [];bg=[];cg=[];
	while ~conBrr,
		Brr = mnBrr + scBrr*normrnd(muBrr,sgBrr,1,length(x));
%		Brr = mnBrr + scBrr*rand(1,length(x));		
		%
		Brr(Brr>mxBrr) = [];
		Brr(Brr<mnBrr) = [];
		%
		nBrr = numel(Brr);
		nap  = n - nBrr 
		if nap>0,
			apBrr = rand(1,nap);
			Brr = [Brr apBrr];
		end
		%
		sgBrr = sgBrr + sgBrStp;	
		% Check for collocation points.
		colBrrPth = [pN 'colBrr.mat'];
		Root = aPoly_Construction(Brr,2,colBrrPth);
		%load(colBrrPth);
		% Check roots
		erBrr1 = abs(Root(1)-colBrrR1);
		erBrr2 = abs(Root(2)-colBrrR2);
		erBrr3 = abs(Root(3)-colBrrR3);
		conBr1 = ~(erBrr1>tolBrr);
		conBr2 = ~(erBrr2>tolBrr);
		conBr3 = ~(erBrr3>tolBrr);
		conBrr = (conBr1*conBr2*conBr3);
%		hold on
%		pause(0.0);
%		plot(erBrr1,'b');plot(erBrr2,'g');plot(erBrr3,'r');
		display(['error is ' num2str(erBrr1) ' ' num2str(erBrr2) ' ' num2str(erBrr3)]);
		if sgBrr> sgBrre,
%			clf;hold on;
%			plot(Br,'b'); 
%			plot(bg,'g');
%			plot(cg,'r');
			display('Convergence problem!');
			error('The BSHT did not converge, try settings Brain');
		end
		Br(end+1)=erBrr1;
		bg(end+1)=erBrr2;
		cg(end+1)=erBrr3;
	end
	
	BrrPth =[pN '/Brr_' num2str(nd) '.mat'];
	save(BrrPth, 'Brr');
%
figure();
hist(Brr,round(ns/100));
end

