function [] = rmRstMat(caseName)
%RMRSTMAT Remove Restart Mat File
%   rmRstMat(caseName) removes the mat file for the restart outputs of case
%   caseName.
%
%   See also rmRst.

%%
%
rstMat = [pthVCT(caseName) caseName '_RST.mat'];
%
cmd = ['rm ' rstMat];
%
system(cmd);
%
%
msg = ['Successful removal of rst mat file for' caseName ' (:D).'];
display(msg);
logIt(msg);
%
end

