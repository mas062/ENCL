function [] = convAllRst(scnTmp)
%CONVALLRst Convert All Eclipse Restart Data
%   convAllRst(scnTmp) loads, converts and saves Restart output for all the
%   realizations into a format available for plot and visualization. Data
%   related to runs of scenario template scnTmp are used.
%
%   See also convEclRst, mkRV.

%%
h = @(x) task(x);
allCases(scnTmp,h);
%
end
%
function [] = task(caseName)
rstMat = [pthVCT(caseName) caseName '_RST.mat'];
if ~exist(rstMat,'file'),
%    lstRst = [pthSCN(caseName) caseName '.F0401'];
%     if ~exist(lstRst,'file'),         
    unzipRst(caseName);
%     end
    convEclRst(caseName);
    rmRst(caseName);
% zipRst(caseName);
else
    %
    msg = ['Restarts for ' caseName ' are already converted.'];
    display(msg);
    logIt(msg);
    % 
end
end