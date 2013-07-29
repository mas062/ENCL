%% Mouse Point Value
% Selects a cell on the 2D view grid by mouse click. Useful for well
% postion decisions and individual cell property monitoring on the grid.
function [] = pointVal(G,h,prop)
    ind = [];
    setappdata(gca,'uistate',uisuspend(gcf))
    while gca == h
        if ~isempty(ind)
            plotCellData(G,prop,ind,'FaceColor','k','EdgeColor','k');
        end
        indP = ind;
        [x y z] = xyzp;
        [Y,ind]= min(sum(abs(G.cells.centroids(:,1)-x)+...
                     abs(G.cells.centroids(:,2)-y)+...
                     abs(G.cells.centroids(:,3)-z),2));
        plotCellData(G,prop,indP);
%         display(prop(ind));ind
    end
    uirestore(getappdata(gca,'uistate'));    
end
%% Mouse Point XYZ
% Returns the cell center coordinates of the pointed cell by mouse click.
function [xp yp zp] = xyzp()
    waitforbuttonpress
    point = get(gca,'CurrentPoint');    % button down detected
    xp = point(1,1);
    yp = point(1,2);
    zp = point(1,3);
end
