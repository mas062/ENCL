function [] = saveFig(h,caseName,pn,varargin)
%SAVEFIG Save Figure
%   saveFig(h,caseName,pn,varargin) saves the figure in handle h in to VIZ
%   folder relevant to the case caseName. The property name pn is used for
%   naming the file and if the figure belongs to a specific time step, that
%   can me given in varargin as an extra input.
%
%   See also mkRv.

%%
%
% csD = rpth(caseName);
% rsltD = csD(1:end-4);
% vizD = [rsltD 'RSLT/VIZ/'];
% if ~exist(vizD,'dir'),
%     cmd = ['mkdir ' vizD];
%     system(cmd);
% end
mkVIZ(caseName);
%
ts = 'i';
ly = 'a';
%
if ~isempty(varargin),
    ly = num2str(cell2mat(varargin(1)));
    if nargin>4,ts = num2str(cell2mat(varargin(2)));end
end
%
rN = ['FIG' caseName(5:end) '_' pn '_' kpdg(ly,2) '_' kpdg(ts,4)];
fN =[vizD rN];
%
saveas(h,fN,'jpg');
%
end
