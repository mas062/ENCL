function [] = mkbVCT(caseName)
%MKBVCT Make VCT folder
%   mkbVCT(caseName) makes the VCT folder which is to contain result
%   information of the run which is specific to case caseName.
%   
%   See also mkbSCN, mkbCMD, mkSINC.

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

% Check for VCT folder
vctbD = pthbVCT(caseName);
if ~exist(vctbD,'dir'),
    cmd = ['mkdir ' vctbD];
    system(cmd);
end

end
