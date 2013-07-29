function showGrid = gridViz(G,cellNum,prop,pname,edge)
%% Plot Filters
%   showGrid = gridViz(G,cellNum,prop,pname,edge)
%   Plots the specified property on the filtered grid.

%%
if ~isempty(cellNum);
      showGrid = plotCellData(G, prop, cellNum, 'EdgeColor', edge);
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