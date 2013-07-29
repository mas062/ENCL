function [] = mkbSINC(caseName)
%MKSINC Make SINC folder
%   mkSINC(caseName) makes the SINC folder which is to contain include
%   files for Eclipse models specific to the case caseName.
%   
%   See also mkSCN, mkCMD, mkSINC.

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

% Check for CMD folder
sincbD = pthbSINC(caseName);
if ~exist(sincbD,'dir'),
    cmd = ['mkdir ' sincbD];
    system(cmd);
end
end
