function [vc,tc,cl] = rspVct(prop,nd)
%RSPVCT Response Vector
%   rspVct converts the run outputs over the input collocation points into
%   a Matlab vector to be used in sensitivity and risk assessment.
%
%   See also csDim, polyGen, polyTune.

%%
rspns = [];
vr = [];

%% Load collocation point bases 

pD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
polyFile = [pD 'polynomial.mat'];
load(polyFile,'CollocationPointsBase');
P = size(CollocationPointsBase,1);
for i=1:P,
    caseName = col2cs(CollocationPointsBase(i,:),nd);
    if runOk(caseName),
        [varVal,varInd] = cs2col(caseName);
        %
        vctN = [pthVCT(caseName) caseName '_PLT.mat'];
        pr = load(vctN,prop);
        %
        rspns{end+1}=eval(['pr.' prop]);   
        vr{end+1}  =varVal; 
        %
    end
end

%% Uinform Results Resolution
%

TimeStep = [];
%rsI=[];
isSmry = (prop(1)=='F')+(prop(1)=='W');
%
if isSmry, 
    tstp = 'smryT';
else 
    tstp = 'rstT';
end
for i=1:P,
	cs = col2cs(CollocationPointsBase(i,:),nd);
	pltN = [pthVCT(cs) cs '_PLT.mat'];
	load(pltN,tstp);
	load(pltN,'rstTI');
	TStep = eval(tstp);
	if ~isSmry, 
		TimeStep{end+1} = TStep(rstTI(:)+1);
	else
		TimeStep{end+1} = TStep;
	end
end
reUni = true;
rsp = rspns;
unt = TimeStep;
while reUni,
	[rsp,unt] = uniVec(rsp,unt);
	rsp = rsp(~cellfun('isempty',rsp));
	unt = unt(~cellfun('isempty',rsp));
	mxt = unt{1};
	for i = 1:length(unt),
		if length(unt{i})>=length(mxt),
			mxt = unt{i};
		end
	end
	%
	% reporting
	display(['maximum time lngth is ' num2str(length(mxt))]);
%	display(['maximum time lngth is ' length(mxt)]);
	for t=1:length(rsp),
		if length(rsp{t})~=length(mxt),
			reUni=true;
			break
		else
			reUni=false;
		end
	end 
end
%% Retun Values
%
cl = vr;
tc = mxt;
vc = rsp;
%
end


