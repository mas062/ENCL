function [] = histCurve(data)
%HISTCURVE Histogram Curve
%   histCurve(x,y) makes histogram plot in curve on the current active
%   figure.
%
%   See also hist, scatterIt.

%%
%
numbins = 25;
n = length(data);
binwidth = range(data)/numbins;
edg= min(data):binwidth:max(data);
[count, bin] = histc(data, edg);
h = bar(edg, count, 'histc');
set(h, 'facecolor', [0.8 0.8 1]); % change the color of the bins
set(h, 'edgecolor', [0.8 0.8 1]);
save count;
hold on;
plot(edg,count);    % plot(p,edg) is the smooth curve representing the probability density function you are looking for.
hold off; 
end

