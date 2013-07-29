function [] = mkCMD(caseName)
%MKCMD Make SCN folder
%   mkCMD(caseName) makes the CMD folder which is to contain the command
%   files(.csh).
%   
%   See also mkSCN, mkRPT, mkSINC.

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
cmdD = pthCMD(caseName);
if ~exist(cmdD,'dir'),
    cmd = ['mkdir ' cmdD];
    system(cmd);
end
end
