function [] = bkAllVAR()
%BKALLVAR  Back-up All VAR Folders
%   bkAllVAR() makes a copy of the VAR folders for the realizations on the
%   backup disk.
%
%   See also mkRL, mkCase, dataClass.

%%
h =@(x) task(x);
allRlz(h);
end
function [] = task(rlz)
%
mdVar = pthVAR(rlz);
bdVar = pthbVAR(rlz);
%
if ~exist(bdVar,'dir'),
    mkbVAR(rlz);
end
%
bkUp(strrep(mdVar,enclDir,''));
%
end