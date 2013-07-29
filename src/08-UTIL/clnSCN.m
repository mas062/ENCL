function [] = clnSCN(caseName)
%CLNSCN Clean SCN Folder
%   clnSCN(caseName) removes all SCN folder containts for case caseName. 
%
%   See also rmRst, rmSmry.

%%
runD = pthSCN(caseName);
if exist(runD,'file'),
    cmd = ['rm ' runD '*'];
    system(cmd);
end
%
end

