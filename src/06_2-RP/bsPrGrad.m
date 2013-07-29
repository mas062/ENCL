function [gradPr] = bsPrGrad(scn,prop,basis)
%BSGRAD Basis Gradient
%   [gradP] = bsPrGrad(scn,prop,basis) returns the gradient of 
%   property prop respect to basis for scenario scn. 'basis' is a number from 1 to 5, for different geological feature considered in the study:
%   1: Fault
%   2: Lobosity
%   3: Barriers
%   4: Aggradation
%   5: Progradation
%   This grad value can be used to find the most influencial basis on the
%   studied property.
% 
%   See also, crossAll.

%%
global A B C bs c d ppt doReturn;
%
A = [];
%
ppt = prop;
bs = basis;
doReturn = false;
%
allCases(scn,@task);
%
if doReturn, 
    msg = 'No plotting vectors are available';
    display(msg);
    logIt(msg);
    return; 
end;
%
a = mean(A);
b = mean(B);
c = mean(C);
y = [a b c];
y(isnan(y))=[];
x = [1:length(y)];
%
pl = polyfit(x,y,1);
gradPr = pl(1);
% 
end
function [] = task(caseName)
%%
global A B C bs c d ppt doReturn;
%
fN_INIT = [pthVCT(caseName) caseName '_INIT.mat'];
fN_PLT = [pthVCT(caseName) caseName '_PLT.mat'];
fN_SMRY = [pthVCT(caseName) caseName '_SMRY.mat'];
%
int =exist(fN_INIT,'file');
plt =exist(fN_PLT,'file');
smry =exist(fN_SMRY,'file');
%
if plt && smry && int,
    %
    load(fN_INIT);
    load(fN_PLT);
    load(fN_SMRY);
    %
    P = eval(ppt);
    if isempty(P), P=0;end
	 %
    dims = nD(case2cls(caseName));
    if ismember(bs,2:5),
        level = dims(bs);
        %
        switch level,
            case 1,
                A(end+1) = P;
            case 2,
                B(end+1) = P;
            case 3,
                C(end+1) = P;
        end
    elseif bs==1,
        rlz = strrep(case2rlz(caseName),['R_' case2cls(caseName)...
             '_SC'],'');
        switch rlz,
            case '001',
                A(end+1) = P;
            case '005',
                B(end+1) = P;
            case '041',
                C(end+1) = P;
        end                
    else
        %
        doReturn = true;
        % 
    end            
    c(end+1) = nD2lin(nD(case2cls(caseName)));
    d(end+1) = str2num(caseName(10:12));
    %
else
    %
    doReturn = true;
    % 
end
end
