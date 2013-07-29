function [] = mkVAR(rlz)
%MKVAR Make VAR Directory
%   mkVAR(rlz) Makes the VAR directory for the realization rlz.
%
%   See also mkRINC, pthVAR.

%%
cls = rlz2cls(rlz);
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

% Check for VAR folder
if ~exist(pthVAR(rlz),'dir'),
        cmd = ['mkdir ' pthVAR(rlz)];
        system(cmd);
end    
end

