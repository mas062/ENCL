function [] = apreFltr(scnTmp,dim,sbc)
%APREFLTR Apre Fliltered Cases
%   apreFltr(scnTmp,dim,sbc) does the after run tasks like zipping RST filesand
%   removing them afterwards....

%   See also convEclInit, mkRP, mkRV.

%%
%
h = @(x) apreRun(x);
fltrCases(scnTmp,h,dim,sbc);
%                        
end