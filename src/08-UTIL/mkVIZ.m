function [] = mkVIZ(caseName)
%MKVIZ Make VIZ folder
%   mkVIZ(caseName) makes the VIZ folder which is to contain result
%   figures of 3D visualizations for the run which is specific to case
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

% Check for VIZ folder
vizD = pthVIZ(caseName);
if ~exist(vizD,'dir'),
    cmd = ['mkdir ' vizD];
    system(cmd);
end
end
