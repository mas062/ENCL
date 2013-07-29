function [rsp,unt,vr] = rspVctInt(prop,nd)
%RSPVCTINT Response Vector Interpolation
%   rspVctInt(prop,nd) converts the run outputs over the input collocation points into
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
    if 1,%runOk(caseName),
        [varVal,varInd] = cs2col(caseName);
        %
        vctN = [pthVCT(caseName) caseName '_PLT.mat'];
        pr = load(vctN,prop);
        %
        rspns{end+1}=eval(['pr.' prop]);   
        vr{end+1}  =varVal; 
        %
    else
    	display(['run was not Ok for ' caseName '!']);
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
[rsp,unt] = uniVecInt(rsp,unt);
%% Retun Values
%
%
end


