function [showGrid,hC]= gridLogViz(G,cellNum,prop,pname,edge)
%% Plot Log plot
%   showGrid = gridViz(G,cellNum,prop,pname,edge)
%   Plots the specified property on the filtered grid.

%%
if ~isempty(cellNum),
   % D is your data
   % Rescale data 1-64
   d = log10(prop);
   mn = min(d(:));
   rng = max(d(:))-mn;
   d = 1+63*(d-mn)/rng; % Self scale data
   showGrid = plotCellData(G, d, cellNum, 'EdgeColor', edge);
   hC = colorbar;
   L = [0.01 0.02 0.05 0.1 0.2 0.5 1 2 5 10 20 50 100 200 500 1000 2000 5000];
   % Choose appropriate
   % or somehow auto generate colorbar labels
   l = 1+63*(log10(L)-mn)/rng; % Tick mark positions
   set(hC,'Ytick',l,'YTicklabel',L);
else
   showGrid = plotGrid(G,'FaceColor','none','EdgeColor',[0.65 0.65 0.65]);
end
view([1 1 -1]);colorbar;title(pname);
set(gca, 'YDir', 'reverse');
%     for i=1:1:90
%         view(i,45+i);
%         pause(0.001);
%     end
end