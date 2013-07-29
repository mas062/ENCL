function [ varargout ] = discColPlt( G,cellNum,prop,pname,edge,dc,varargin )
%DISCRCOLPLT Discrete Color Plot
%   discColPlt(G,cellNum,prop,pname,edge ) plots the property prop on the
%   grid G with discrete unisize color interval number dc. pname is a text
%   of the property name and edge is the color of the cell edges. min and 
%   max of the interval can be given at the end of argument.
%
%   See also gridViz.

%%
discProp = prop;
if ~isempty(varargin)
    if  ~isempty(varargin(1)) && ~isempty(varargin(2)),
        cmin = min(varargin(1),varargin(2));
        cmax = max(varargin(1),varargin(2));
    end
else
    cmin = min(prop);
    cmax = max(prop);
end
%
c = linspace(cmin,cmax,dc+1);
cav = [];
%
for i=1:dc
    cav(end+1) = mean([c(i),c(i+1)]);
    discProp(valFltr(prop,c(i),c(i+1))) = cav(end);
end
%   
figure;
subplot(1,5,[1:4])
if ~isempty(cellNum);
      plotCellData(G, discProp, cellNum, 'EdgeColor', edge);
    else
      plotGrid(G,'FaceColor','none','EdgeColor',[0.65 0.65 0.65]);
    end
subplot(155);
x=1;y=c;
[xx,yy]=meshgrid(x,y);
imagesc(xx,yy(end:-1:1),cav');
h=gca;
set(h,'PlotBoxAspectRatio',[1,20,1]);
set(h,'YAxisLocation','right');
set(h,'XTick',[]);
set(h,'YTickLabel',cav(end:-1:1)');
set(h,'YTick',cav(:)');
title(pname);
subplot(1,5,[1:4])

end

