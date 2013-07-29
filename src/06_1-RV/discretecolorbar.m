function [ varargout ] = discretecolorbar(h,vmin,vmax,cn,pn)
%DISCRETECOLORBAR Discrete Color Bar
%   discretecolorbar(h,vmin,vmax,cn) Draws discrete color bar for handle h.
%   vmin and vmax are the minimum and maximum of the whole interval and cn
%   is number of the intervals.
%
%   See also discretecolor.
gcf=h;
hc = colorbar('peer',gca);
t = linspace(vmin,vmax,cn+1);
c = (t(1:end-1)+t(2:end))/2;
if cn~=5, set(hc,'YTick',c);end
pos = get(hc,'Position');
txt = text(pos(1),pos(2),pn);
set(txt,'Parent',hc);
set(hc,'Title',txt);
end
