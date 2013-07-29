function [] = convAllGrd(scnTmp)
%CONVALLGRD Convert All Grid Data
%   convAllGrd(scnTmp) loads and converts Eclipse grid data for all the
%   realizations into a format available for plots and visualization. Data
%   related to runs of scenario template scnTmp are used.
%
%   See also convEclInit, mkRP, mkRV.

%%
h = @(x) convEclGrd(x);
allCases(scnTmp,h);
%
end