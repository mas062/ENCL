function [ varargout ] = ttlColBar( h,pn )
%TTLCOLBAR Title Color Bar
%   ttlColBar(h,pn) puts the title pn on the colorbar of handle h.
%
%   See also discretecolorbar.

%%
%
figure(h);
hc = colorbar('peer',gca);
pos = get(hc,'Position');
txt = text(pos(1),pos(2),pn);
set(txt,'Parent',hc);
set(hc,'Title',txt);
end

