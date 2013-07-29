function [] = bwVar(nd,ns)
%BwVAR Bwgradation Variables
%   BwVar generates the Bwgradation variable distributions and saves them in
%   directory DST in DATA
% 
%   See also inVar, brVar, ftVar, bwVar.
%
%% Fault Transmissibility Multiplier

dn = 1/ns;
x  = [0:dn:1];
n  = numel(x);

pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
if ~exist(pN,'dir'), system(['mkdir ' pN]);end

%
%%%%%%%%%%%%%%%%

%% Bwgradation
% 

% 
	mnBkw = 0;
	mxBkw = 1;
	scBkw = 1;
    %
    mn = 290;
	mx = 390;
	sc = 100;

	%
	colBkwR1 = 0.9;
	colBkwR2 = 0.5;
	colBkwR3 = 0.1;
	tolBkw   = 0.05; 
	conBkw   = false;
	%
	muBkw = 0.5;
	sgBkw = 0.0001;
	sgBkwe = 10;
	sgBwStp= 0.001;
	%
	Bw = [];bg=[];cg=[];
	while ~conBkw,
		Bkw = mnBkw + scBkw*normrnd(muBkw,sgBkw,1,length(x));
%		Bkw = mnBkw + scBkw*rand(1,length(x));		
		%
		Bkw(Bkw>mxBkw) = [];
		Bkw(Bkw<mnBkw) = [];
		%
		nBkw = numel(Bkw);
		nap  = n - nBkw 
		if nap>0,
			apBkw = rand(1,nap);
			Bkw = [Bkw apBkw];
		end
		%
		sgBkw = sgBkw + sgBwStp;	
		% Check for collocation points.
		colBkwPth = [pN 'colBkw.mat'];
		Root = aPoly_Construction(Bkw,2,colBkwPth);
		%load(colBkwPth);
		% Check roots
		erBkw1 = abs(Root(1)-colBkwR1);
		erBkw2 = abs(Root(2)-colBkwR2);
		erBkw3 = abs(Root(3)-colBkwR3);
		conBw1 = ~(erBkw1>tolBkw);
		conBw2 = ~(erBkw2>tolBkw);
		conBw3 = ~(erBkw3>tolBkw);
		conBkw = (conBw1*conBw2*conBw3);
%		hold on
%		pause(0.0);
%		plot(erBkw1,'b');plot(erBkw2,'g');plot(erBkw3,'r');
		display(['error is ' num2str(erBkw1) ' ' num2str(erBkw2) ' ' num2str(erBkw3)]);
		if sgBkw> sgBkwe,
%			clf;hold on;
%			plot(Bw,'b'); 
%			plot(bg,'g');
%			plot(cg,'r');
			display('Convergence problem!');
			error('The BSHT did not converge, try settings Bwain');
		end
		Bw(end+1)=erBkw1;
		bg(end+1)=erBkw2;
		cg(end+1)=erBkw3;
	end
	Bkw = mn+sc*Bkw;
	BkwPth =[pN '/Bkw_' num2str(nd) '.mat'];
	save(BkwPth, 'Bkw');
%
figure();
hist(Bkw,100);
end

