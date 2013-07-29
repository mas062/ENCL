function [vc,tc,cl] = rspVct3D()
%RSPVCT3D Response Vector 3D
%   rspVct3D converts the run outputs over the input collocation points into
%   a Matlab vector to be used in sensitivity and risk assessment.
%
%   See also csDim, polyGen, polyTune.

%%
rspns = [];
vr = [];

%% Load collocation point bases 

pD = ['/Home/siv16/mas062/prjII/aPC/DATA/'];
polyFile = [pD 'polynomial.mat'];
load(polyFile,'CollocationPointsBase');
P = size(CollocationPointsBase,1);
for i=1:P,
    caseName = col2cs(CollocationPointsBase(i,:));
    if runOk(caseName),
        [varVal,varInd] = cs2col(caseName);
        %
        vctN = [pthVCT(caseName) caseName '_RST.mat'];
        load(vctN);
        %
        rspns{end+1}=rst.SWAT;   
        vr{end+1}  =varVal; 
        %
        clear rst;
    end
end

%% Uinform Results Resolution
%

TimeStep = [];
tstp = 'rstT';
for i=1:P,
	cs = col2cs(CollocationPointsBase(i,:));
	pltN = [pthVCT(cs) cs '_PLT.mat'];
	load(pltN,tstp);
	load(pltN,'rstTI');
	TStep = eval(tstp);
	TimeStep{end+1} = TStep;
end

reUni = true;
%% Retun Values
%
cl = vr;
tc = TStep;
vc = rspns;
%
end


