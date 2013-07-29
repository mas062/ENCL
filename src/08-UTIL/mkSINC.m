function [] = mkSINC(caseName)
%MKSINC Make SINC folder
%   mkSINC(caseName) makes the SINC folder which is to contain include
%   files for Eclipse models specific to the case caseName.
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
sincD = pthSINC(caseName);
if ~exist(sincD,'dir'),
    cmd = ['mkdir ' sincD];
    system(cmd);
end
end
