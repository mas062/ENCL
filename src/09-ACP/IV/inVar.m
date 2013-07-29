function [] = inVar()
%INVAR Input Variables
%   inVar generates the input variable distributions and saves them in
%   directory DST in DATA
% 
%   See also scnTmp.

%% Fault Transmissibility Multiplier
% log-normal distribution
x  = [0:0.0001:1];
n  = numel(x);
acpPth = [enclDir 'ACP/'];
%
%% Barrier
% 
alreadyCalculated = true;
if ~alreadyCalculated,
	mnBrr = 0;
	mxBrr = 1;
	scBrr = 1;
	%
	colBrrR1 = 0.9;
	colBrrR2 = 0.5;
	colBrrR3 = 0.1;
	tolBrr   = 0.015; 
	conBrr   = false;
	%
	muBrr = 0.5;
	sgBrr = 0.01;
	sgBrre = 1;
	sgBrStp= 0.001;
	%
	a = [];b=[];c=[];
	while ~conBrr,
		brr = mnBrr + scBrr*normrnd(muBrr,sgBrr,1,length(x));
		%
		brr(brr>mxBrr) = [];
		brr(brr<mnBrr) = [];
		%
		nBrr = numel(brr);
		nap  = n - nBrr 
		if nap>0,
			apBrr = rand(1,nap);
			brr = [brr apBrr];
		end
		%
		sgBrr = sgBrr + sgBrStp;	
		% Check for collocation points.
		colBrrPth = [acpPth 'colBrr.mat'];
		Root = aPoly_Construction(brr,2,colBrrPth);
		%load(colBrrPth);
		% Check roots
		erBrR1 = abs(Root(1)-colBrrR1);
		erBrR2 = abs(Root(2)-colBrrR2);
		erBrR3 = abs(Root(3)-colBrrR3);
		conBr1 = ~(erBrR1>tolBrr);
		conBr2 = ~(erBrR2>tolBrr);
		conBr3 = ~(erBrR3>tolBrr);
		conBrr = (conBr1*conBr2*conBr3);
		hold on
		%pause(0.0);
		%plot(erBrR1,'b');plot(erBrR2,'g');plot(erBrR3,'r');
		display(['error is ' num2str(erBrR1) ' ' num2str(erBrR2) ' ' num2str(erBrR3)]);
		if sgBrr> sgBrre,
			clf;hold on;
			plot(a,'b'); 
			plot(b,'g');
			plot(c,'r');
			display('Convergence problem!');
			error('The BSHT did not converge, try settings again');
		end
		a(end+1)=erBrR1;
		b(end+1)=erBrR2;
		c(end+1)=erBrR3;
	end

	brrPth =[acpPth '/nBrr.mat'];
	save(brrPth, 'brr');
else
	brrPth =[acpPth '/nBrr.mat'];
	load(brrPth);
end

%%%%%%%%%%%%%%%%

%% Aggradation
% 

% 
alreadyCalculated = true;
if ~alreadyCalculated,
	mnAgr = 0;
	mxAgr = 1;
	scAgr = 1;
	%
	colAgrR1 = 0.9;
	colAgrR2 = 0.5;
	colAgrR3 = 0.1;
	tolAgr   = 0.01; 
	conAgr   = false;
	%
	muAgr = 0.5;
	sgAgr = 0.0001;
	sgAgre = 10;
	sgAgStp= 0.001;
	%
	ag = [];bg=[];cg=[];
	while ~conAgr,
		agr = mnAgr + scAgr*normrnd(muAgr,sgAgr,1,length(x));
		%
		agr(agr>mxAgr) = [];
		agr(agr<mnAgr) = [];
		%
		nAgr = numel(agr);
		nap  = n - nAgr 
		if nap>0,
			apAgr = rand(1,nap);
			agr = [agr apAgr];
		end
		%
		sgAgr = sgAgr + sgAgStp;	
		% Check for collocation points.
		colAgrPth = [acpPth 'colAgr.mat'];
		Root = aPoly_Construction(agr,2,colAgrPth);
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
		%pause(0.0);
	%	plot(erAgR1,'b');plot(erAgR2,'g');plot(erAgR3,'r');
		display(['error is ' num2str(erAgR1) ' ' num2str(erAgR2) ' ' num2str(erAgR3)]);
		if sgAgr> sgAgre,
			clf;hold on;
			plot(ag,'b'); 
			plot(bg,'g');
			plot(cg,'r');
			display('Convergence problem!');
			error('The BSHT did not converge, try settings again');
		end
		ag(end+1)=erAgR1;
		bg(end+1)=erAgR2;
		cg(end+1)=erAgR3;
	end
	
	agrPth =[acpPth '/nAgr.mat'];
	save(agrPth, 'agr');
else

	agrPth =[acpPth '/nAgr.mat'];
	load(agrPth);
end

% %% %%% %%%% %%%%% %%%%%%
% Fault Transmissibility
%
alreadyCalculated = true;%false;
if ~alreadyCalculated,
	mnFts = 0;
	mxFts = 1;
	scFts = 1;
	%
	colFtsR1 = 0.8570;
	colFtsR2 = 0.5143;
	colFtsR3 = 0.2592;
	tolFts   = 0.041; 
	conFts   = false;
	%
	muFts = 0.5;
	sgFts = 0.0001;
	sgFtse = 1;
	sgFtStp= 0.001;
	%
	af = [];bf=[];cf=[];
	while ~conFts,
		fts = mnFts + scFts*normrnd(muFts,sgFts,1,length(x));
		%
		fts(fts>mxFts) = [];
		fts(fts<mnFts) = [];
		%
		nFts = numel(fts);
		nap  = n - nFts 
		if nap>0,
			apFts = rand(1,nap);
			fts = [fts apFts];
		end
		%
		sgFts = sgFts + sgFtStp;	
		% Check for collocation points.
		colFtsPth = [acpPth 'colFts.mat'];
		Root = aPoly_Construction(fts,2,colFtsPth);
		%load(colFtsPth);
		% Check roots
		erFtR1 = abs(Root(1)-colFtsR1);
		erFtR2 = abs(Root(2)-colFtsR2);
		erFtR3 = abs(Root(3)-colFtsR3);
		conFt1 = ~(erFtR1>tolFts);
		conFt2 = ~(erFtR2>tolFts);
		conFt3 = ~(erFtR3>tolFts);
		conFts = (conFt1*conFt2*conFt3);
		hold on
		%pause(0.0);
	%	plot(erFtR1,'b');plot(erFtR2,'g');plot(erFtR3,'r');
		display(['error is ' num2str(erFtR1) ' ' num2str(erFtR2) ' ' num2str(erFtR3)]);
		if sgFts> sgFtse,
			clf;hold on;
			plot(af,'b'); 
			plot(bf,'g');
			plot(cf,'r');
			display('Convergence problem!');
			ftsPth =[acpPth '/eFts.mat'];
			save(ftsPth, 'fts');
			error('The BSHT did not converge, try settings again');
			
		end
		af(end+1)=erFtR1;
		bf(end+1)=erFtR2;
		cf(end+1)=erFtR3;
	end
	
	ftsPth =[acpPth '/nFts.mat'];
	save(ftsPth, 'fts');
else

	ftsPth =[acpPth '/nFts.mat'];
	load(ftsPth);
end



%% Fault Transmissibility Multiplier
%% log-normal distribution
%x  = [0:0.0001:1];
%l = [0,1];
%m = 0.5;
%v = 0.05;
%mu = log((m^2)/sqrt(v+m^2));
%sigma = sqrt(log(v/(m^2)+1));
%% Distribution construction
%X  = lognrnd(mu,sigma,1,length(x));
%X(X>1)=rand(size(X(X>1)));
%% Sample generation
%X  = invSmpling(x,F,l);
%fts = X;

%% Background Water 
% Constant pressure aquifer used both lateral sides of the model.
% Range of 50 bars pressure over the medium is distributed normally as
% input.
mxPrs = 100;
mnPrs = 290;
bkw = mnPrs + mxPrs*brr;

%% Relative Permeability Curvature
%pn = 1+normrnd(0.5,0.2,1,1001);


% 
% Sw = 0:0.1:1;
% Sn = 1-Sw;
% Krw = Sw.^pn;
% Krn = Sn.^pn;
% 
%% Save output
pN = [enclDir 'ACP/'];
%
varName = {'bar' 'agr' 'fts' 'bkw'};
%
vN = [pN 'varN.mat'];
vN1 = [pN 'brr.mat'];
vN2 = [pN 'agr.mat'];
vN3 = [pN 'fts.mat'];
vN4 = [pN 'nBkw.mat'];
%
save(vN,'varName');
%save(vN3,'fts');
save(vN4,'bkw');
%

end

