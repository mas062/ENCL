function [] = mkPLT(caseName)
%MKPLT Make PLT folder
%   mkPLT(caseName) makes the PLT folder which is to contain result
%   figures of line plots for the run which is specific to case
%   caseName.
%   
%   See also mkSCN, mkCMD, mkSINC.

%%

rlz = case2rlz(caseName); 
cls = case2cls(caseName); 

% Check for class folder
clsD = clsDir(cls);
if ~exist(clsD,'dir'),
    cmd = ['mkdir ' clsD];
    system(cmd);
end

% Check for realization folder
rlzD = rlzDir(rlz);
if ~exist(rlzD,'dir'),
    cmd = ['mkdir ' rlzD];
    system(cmd);
end

% Check for case folder
caseD = caseDir(caseName);
if ~exist(caseD,'dir'),
    cmd = ['mkdir ' caseD];
    system(cmd);
end

% Check for RSLT folder
mkRSLT(caseName);

% Check for PLT folder
pltD = pthPLT(caseName);
if ~exist(pltD,'dir'),
    cmd = ['mkdir ' pltD];
    system(cmd);
end
end
