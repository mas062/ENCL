function [] = convAllInit(scnTmp)
%CONVALLINIT Convert All INIT Data
%   convAllInit(scnTmp) loads and converts Eclipse INIT outputs for all the
%   realizations into a format available for plots and visualization. Data
%   related to runs of scenario template scnTmp are used.
%
%   See also convEclInit, mkRP, mkRV.

%%
%
h = @(x) convEclInit(x);
allCases(scnTmp,h);
%                        
end