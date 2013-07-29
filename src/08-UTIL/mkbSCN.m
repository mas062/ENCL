function [] = mkbSCN(caseName)
%MKBSCN Make Back-up SCN folder
%   mkbSCN(caseName) makes the SCN folder which is to contain the run 
%   files.
%   
%   See also mkAllSCN, mkAllCase.

%%

rlz = case2rlz(caseName); 
cls = case2cls(caseName); 

% Check for class folder
clsbD = clsbDir(cls);
if ~exist(clsbD,'dir'),
    cmd = ['mkdir ' clsbD];
    system(cmd);
end

% Check for realization folder
rlzbD = rlzbDir(rlz);
if ~exist(rlzbD,'dir'),
    cmd = ['mkdir ' rlzbD];
    system(cmd);
end

% Check for case folder
casebD = casebDir(caseName);
if ~exist(casebD,'dir'),
    cmd = ['mkdir ' casebD];
    system(cmd);
end

% Check for SCN folder
scnbD = pthbSCN(caseName);
if ~exist(scnbD,'dir'),
    cmd = ['mkdir ' scnbD];
    system(cmd);
end
end
