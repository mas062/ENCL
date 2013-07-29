function [] = mkRINC(rlz)
%MKRINC Make RINC Directory
%   mkRINC(rlz) Makes the RINC directory for the realization rlz.
%
%   See also mkAllRINC, pthRINC.

%%
rlzD = [enclDir 'DATA/CLS/' rlz2cls(rlz) '/' rlz '/'];
    if ~exist(rlzD,'dir'),
        cmd = ['mkdir ' rlzD];
        system(cmd);
    end    
    if ~exist(pthRINC(rlz),'dir'),
        cmd = ['mkdir ' pthRINC(rlz)];
        system(cmd);
    end    
end

