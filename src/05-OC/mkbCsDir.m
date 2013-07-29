function [] = mkbCsDir(caseName)
%MKBCSDIR Make Backup Case Directory
%   mkbCsDir(caseName) checks for existance of case directory on the back
%   up disk and create the directory if it does not exist.
%   
%   See also mkSCN, mkCMD, mkSINC.

%%
%
rlz = case2rlz(caseName); 
cls = case2cls(caseName); 

% Check for class folder
clsD = clsbDir(cls);
if ~exist(clsD,'dir'),
    cmd = ['mkdir ' clsD];
    system(cmd);
end
% Check for realization folder
rlzD = rlzbDir(rlz);
if ~exist(rlzD,'dir'),
    cmd = ['mkdir ' rlzD];
    system(cmd);
end
% Check for case folder
caseD = casebDir(caseName);
if ~exist(caseD,'dir'),
    cmd = ['mkdir ' caseD];
    system(cmd);
end
%
end