function [] = freqRst(caseName)
%FREQRST Frequency Set RST
%   When the frequency of the output is set in the Eclipse data set, using
%   under BASIC=3 under RPTRST keyword, the corresponding timeindex array 
%   will be appended to the plotting vector.

% Load restart files
%
msg = ['Appending extra restart information(timing) for case ' caseName '...'];
display(msg);
logIt(msg);
% 
fN_RST = [pthVCT(caseName) caseName '_RST.mat'];
if ~exist(fN_RST,'file'),
    convEclDyn(caseName);
end
load(fN_RST);
rstT = rst.times';
%
ti = rst.timeindex';
if rstT(1)~=0, ti=ti(1:end-1);end
rstIT = rstT(ti+1);
pltMat = [pthVCT(caseName) caseName '_PLT.mat'];
save(pltMat,'rstT','rstIT','ti','-append');
%
end

