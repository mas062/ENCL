function [] = apreAll(scnTmp)
%APREALL Apre All
%   apreAll(scnTmp) does the after run tasks like zipping RST filesand
%   removing them afterwards....

%   See also convEclInit, mkRP, mkRV.

%%
%
h = @(x) apreRun(x);
allCases(scnTmp,h);
%                        
end