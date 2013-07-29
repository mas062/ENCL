function [RSP] = vctAll(scn,prpNm)
%VCTALL Vector All
%  [RSP] = vctAll(scn,prop) returns vector for property prop of all cases 
%  in scenario scn.
%
%	See also crossAll.

%%
global A B c d prop doReturn;
A = [];B = [];c = [];d = [];

prop = prpNm;
%
pN = [enclDir() 'PLT/PLT_' scn(1:5) '/'];
fN = [pN scn '_' prop '_CRS.mat'];
cmd = ['mkdir ' pN];
if ~exist(pN,'dir'), system(cmd); end
%
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
RSP = A;
%
end
function [] = task(caseName)
%%
global A B c d prop doReturn;
%
fN_INIT = [pthVCT(caseName) caseName '_INIT.mat'];
fN_PLT = [pthVCT(caseName) caseName '_PLT.mat'];
fN_SMRY = [pthVCT(caseName) caseName '_SMRY.mat'];
%
int = exist(fN_INIT,'file');
plt = exist(fN_PLT,'file');
smry = exist(fN_SMRY,'file');
%
if plt && smry && int,
    %
    load(fN_INIT);
    load(fN_PLT);
    load(fN_SMRY);
    %
    P = eval(prop);
    %
    if ~isempty(P),
    	A(end+1) = P;
    else
    	A(end+1)=0;
    end
    %
    c(end+1) = nD2lin(nDm(case2cls(caseName)));
    d(end+1) = str2num(caseName(10:12));
    %
else
    %
    msg = 'No plotting vectors are available';
    display(msg);
    logIt(msg);
    %
    doReturn = true;
end
end
