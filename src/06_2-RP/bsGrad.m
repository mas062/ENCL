function [gradI gradS] = bsGrad(scn,prop,basis)
%BSGRAD Basis Gradient
%   [gradI gradS] = bsGrad(scn,prop,basis) returns the gradient of 
%   property prop respect to basis for scenario scn, both for end of 
%   injection and end of simulation time. 'basis' is a number from 1 to 5, 
%   for different geological feature considered in the study:
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
global AI AS BI BS CI CS bs c d ppt doReturn;
%
AI = [];
BI = [];
CI = [];
AS = [];
BS = [];
CS = [];
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
aI = mean(AI);
bI = mean(BI);
cI = mean(CI);
yI = [aI bI cI];
yI(isnan(yI))=[];
xI = [1:length(yI)];
%
aS = mean(AS);
bS = mean(BS);
cS = mean(CS);
yS = [aS bS cS];
yS(isnan(yS))=[];
xS = [1:length(yS)];
%
plI = polyfit(xI,yI,1);
gradI = plI(1);
%
plS = polyfit(xS,yS,1);
gradS = plS(1);
% 
end
function [] = task(caseName)
%%
global AI BI CI AS BS CS bs c d ppt doReturn;
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
    smryTimeInd = find(smry.WOIR(1,:));
    smryEOI = smryTimeInd(end);
    rstEOI = max(...
        find((rstT>=(smryT(smryEOI)-1)).*(rstT<=(smryT(smryEOI)+1)))...
    );
    lst = length(rstT);
    %
    P = eval(ppt);
    %
    if strfind(ppt,'it.'), 
        rstEOI = 1;lst = 1;
        P = std(P(1:length(P)));
    end
    %
    dims = nD(case2cls(caseName));
    if ismember(bs,2:5),
        level = dims(bs);
        %
        switch level,
            case 1,
                AI(end+1) = P(rstEOI);
                AS(end+1) = P(lst);
            case 2,
                BI(end+1) = P(rstEOI);
                BS(end+1) = P(lst);
            case 3,
                CI(end+1) = P(rstEOI);
                CS(end+1) = P(lst);
        end
    elseif bs==1,
        rlz = strrep(case2rlz(caseName),['R_' case2cls(caseName)...
             '_SC'],'');
        switch rlz,
            case '001',
                AI(end+1) = P(rstEOI);
                AS(end+1) = P(lst);
            case '005',
                BI(end+1) = P(rstEOI);
                BS(end+1) = P(lst);
            case '041',
                CI(end+1) = P(rstEOI);
                CS(end+1) = P(lst);
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






