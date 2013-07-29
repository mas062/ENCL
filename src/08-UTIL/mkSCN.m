function [] = mkSCN(caseName)
%MKSCN Make SCN folder
%   mkSCN(caseName) makes the SCN folder which is to contain the run files.
%   
%   See also mkAllSCN, mkAllCase.

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

% Check for SCN folder
scnD = pthSCN(caseName);
if ~exist(scnD,'dir'),
    cmd = ['mkdir ' scnD];
    system(cmd);
end
end
