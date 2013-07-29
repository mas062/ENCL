function [] = mkbVAR(rlz)
%MKBVAR Make Back-up VAR Directory
%   mkbVAR(rlz) Makes the VAR directory for the realization rlz.
%
%   See also mkRINC, pthbVAR.

%%
cls = rlz2cls(rlz);
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

% Check for VAR folder
if ~exist(pthbVAR(rlz),'dir'),
        cmd = ['mkdir ' pthbVAR(rlz)];
        system(cmd);
end    
end

