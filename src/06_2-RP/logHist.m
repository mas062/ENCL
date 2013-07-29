function [] = logHist(z,n)
%LOGHIST Logarithmic Histogram
%   Draws a logarithmic(x) histogram for data z. n is number
%	of bins.
%

%%
Z = log10(z);
mn = min(z);
mx = max(z);
lmn = log10(mn);
lmx = log10(mx);
D = linspace(lmn,lmx,n);
N = histc(Z,D);
d = 10.^D;
hb = bar(d,N,'histc');
set(gca,'Xscale','log');
delete(findobj('marker','*'));

%
end
