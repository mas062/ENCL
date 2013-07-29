function [yes_no] = existVct(caseName,vct,varargin)
%EXISTVCT Exist Vector Result
%   [yes_no] = existVct(caseName,vct) returns 1 if the vector mat file
%   exist else 0. More than one vector can be monitored by requesting in
%   varargin and hence yes_no will be a vector of 1 and 0's.
%
%   See also pthVCT.

%%
%

vctPth = pthbVCT(caseName);
%
vctFN = [vctPth caseName '_' vct '.mat'];
%
yes_no = ~(exist(vctFN,'file')==0);
%
if ~isempty(varargin),
    for i=1:length(varargin),
        exVct = char(varargin(i));
        vctFN = [vctPth caseName '_' exVct '.mat'];
        yes_no = [yes_no ~(exist(vctFN,'file')==0)];
    end
end
%
end

