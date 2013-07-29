function [] = mkbPLT(caseName)
%MKBPLT Make PLT folder
%   mkbPLT(caseName) makes the PLT folder which is to contain result
%   figures of line plots for the run which is specific to case
%   caseName.
%   
%   See also mkbSCN, mkbCMD, mkbSINC.

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

% Check for RSLT folder
mkbRSLT(caseName);

% Check for PLT folder
pltbD = pthbPLT(caseName);
if ~exist(pltbD,'dir'),
    cmd = ['mkdir ' pltbD];
    system(cmd);
end
end
