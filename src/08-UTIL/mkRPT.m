function [] = mkRPT(caseName)
%MKRPT Make SCN folder
%   mkRPT(caseName) makes the RPT folder which is to contain the run result
%   reports.
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

% Check for CMD folder
rptD = pthRPT(caseName);
if ~exist(rptD,'dir'),
    cmd = ['mkdir ' rptD];
    system(cmd);
end
end
