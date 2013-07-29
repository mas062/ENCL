function [Grd,init,smry,rst] = loadData(caseName,varargin)
%LOADDATA Load Data
%   loadData(caseName, varargin) loads the run results data for case caseName;
%   varargin is indicator for loading rst: if true, rst will be loaded otherwise
%   rst will be given empty value.
%   See also clcPlt.

%%
%
msg = ['Loading information for case ' caseName '...'];
display(msg);
logIt(msg);
% 
scnTmp = case2scn(caseName);


% Grid information
%
msg = ['Loading grid information for case ' caseName '...'];
display(msg);
logIt(msg);
% 
fN_GRD = [pthVCT(caseName) caseName '_GRD.mat'];
if ~exist(fN_GRD,'file'),
    convEclGrd(caseName);
end
load(fN_GRD);
%

% From init file
%
msg = ['Loading INIT information for case ' caseName '...'];
display(msg);
logIt(msg);
% 
fN_INIT = [pthVCT(caseName) caseName '_INIT.mat'];
if ~exist(fN_INIT,'file'),
    convEclInit(caseName);
end
load(fN_INIT);

% From summary files
%
msg = ['Loading summary information for case ' caseName '...'];
display(msg);
logIt(msg);
% 
fN_SMRY = [pthVCT(caseName) caseName '_SMRY.mat'];
% if ~exist(fbN_SMRY,'file'),
%     convEclSmry(caseName);
% end
% From restart files
%
msg = ['Loading restart information for case ' caseName '...'];
display(msg);
logIt(msg);
% 
fN_RST = [pthVCT(caseName) caseName '_RST.mat'];
if ~exist(fN_RST,'file') || ~exist(fN_SMRY,'file'),
    convEclDyn(caseName);
end
load(fN_RST);
load(fN_SMRY);
lRst = 0;
if ~isempty(varargin),lRst = varargin{1};else lRst = 1;end
if ~lRst,rst = [];end

end

